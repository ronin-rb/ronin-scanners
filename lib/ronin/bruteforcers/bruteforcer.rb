#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2011 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/script'
require 'ronin/wordlist'
require 'ronin/user_name'
require 'ronin/password'
require 'ronin/email_address'
require 'ronin/credential'

require 'thread'
require 'ostruct'

module Ronin
  module Bruteforcers
    class Bruteforcer

      include Script

      # The primary-key of the bruteforcer
      property :id, Serial

      # Primary username to use
      parameter :username, :type        => String,
                           :description => 'Primary username to use'

      # Additional user-names to try
      parameter :usernames, :type        => Array[String],
                            :default     => [],
                            :description => 'Additional user-names to try'

      # Paths to the wordlist file or list of words.
      parameter :wordlist, :description => 'Wordlist file or list of words'

      # Mutation rules to apply to words from the {#wordlist}
      parameter :mutations, :default     => {},
                            :description => 'Hash of mutations to perform'

      # Word generator template
      parameter :word_template, :type        => Array,
                                :description => 'String generator template'

      # Minimum number of words to combine
      parameter :min_words, :type        => Integer,
                            :default     => 1,
                            :description => 'Minimum number of words to use'

      # Maximum number of words to combine
      parameter :max_words, :type        => Integer,
                            :default     => 1,
                            :description => 'Maximum number of words to use'

      # The number of threads to run
      parameter :threads, :type        => Integer,
                          :default     => 0,
                          :description => 'Number of separate threads'

      #
      # Creates a new {Bruteforcer} object.
      #
      # @param [Hash] options
      #   Additional options for the bruteforcer.
      #
      # @api public
      #
      def initialize(options={})
        super(options)

        initialize_params(options)
      end

      def bruteforce(&block)
        each_username do |username|
          if self.threads > 0
            bruteforce_multi_threaded(username,&block)
          else
            bruteforce_single_threaded(username,&block)
          end
        end
      end

      protected

      #
      # Default method that handles initializes and destroying bruteforcing
      # sessions.
      #
      # @yield [session]
      #   The given block will be passed the initialized session.
      # 
      # @yieldparam [OpenStruct] session
      #   The initializes session.
      #
      # @abstract
      #
      # @api public
      #
      def session
        yield OpenStruct.new
      end

      #
      # Default method which handles authenticating with credentials.
      #
      # @param [OpenStruct] session
      #   The session object.
      #
      # @param [String] username
      #   The username to try authenticating with.
      #
      # @param [String] password
      #   The password to try authenticating with.
      #
      # @return [Hash]
      #   The successful credential attributes.
      #
      # @abstract
      #
      # @api public
      #
      def authenticate(session,username,password)
      end

      #
      # Creates a new Credential resource.
      #
      # @param [Hash] attributes
      #   Attributes for the new Credential.
      #
      # @return [Credential]
      #   A new or previously saved Credential resource from the Database.
      #
      # @api semipublic
      #
      def new_credential(attributes)
        Credential.first_or_new(
          :user_name     => UserName.parse(result[:username]),
          :password      => Password.parse(result[:password]),

          :email_address => if result[:email_address]
                              EmailAddress.parse(result[:email_address])
                            end
        )
      end

      #
      # Iterates over each word from the {#wordlist} or String {#word_template}.
      #
      # @yield [word]
      #   The given block will be passed each word.
      #
      # @yieldparam [String] word
      #   A word from the {#wordlist} or String {#word_template}.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      # @raise [Parameters::MissingParam]
      #   The {#wordlists} or {#word_template} parameters must be specified.
      #
      # @api public
      #
      def each_word(&block)
        return enum_for(:each_word) unless block

        unless (self.wordlist || self.word_template)
          raise(Parameters::MissingParam,"no wordlist or word template given")
        end

        if self.wordlist
          Wordlist.new(self.wordlist) do |wordlist|
            if self.min_words > self.max_words
              wordlist.each_n_words(self.min_words,&block)
            elsif self.max_words > 1
              wordlist.each_n_words((self.min_words..self.max_words),&block)
            else
              wordlist.each(&block)
            end
          end
        end

        if self.word_template
          String.generate(self.word_template,&block)
        end
      end

      #
      # Iterates over every user-name.
      #
      # @yield [username]
      #   The given block will be passed each user-name.
      #
      # @yieldparam [String] username
      #   A user-name.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      # @api public
      #
      def each_username(&block)
        return enum_for(:each_username) unless block

        # filter out `nil` and duplicate usernames
        ([self.username] + self.usernames).compact.uniq.each(&block)
      end

      #
      # Iterates over every password.
      #
      # @yield [password]
      #   The given block will be passed each password.
      #
      # @yieldparam [String] password
      #   A generated password.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      # @api public
      #
      def each_password(&block)
        each_word(&block)
      end

      #
      # Bruteforces the username.
      #
      # @param [String] username
      #   The username to use while bruteforcing.
      #
      # @yield [username, password]
      #   The given block will be passed the first valid username and password
      #   pair.
      #
      def bruteforce_single_threaded(username)
        session do |session|
          each_password do |password|
            print_debug "Trying #{username} :: #{password} ..."

            if authenticate(session,username,password)
              print_debug "Found #{username} :: #{password}"
              yield username, password
              break
            end
          end
        end
      end

      #
      # Bruteforces the username, using multiple Threads.
      #
      # @param [String] username
      #   The username to use while bruteforcing.
      #
      # @yield [username, password]
      #   The given block will be passed the first valid username and password
      #   pair.
      #
      def bruteforce_multi_threaded(username)
        passwords       = SizedQueue.new(self.threads)
        password_thread = Thread.new do
          each_password do |password|
            passwords.push password

            print_debug "Trying #{username} :: #{password} ..."
          end

          # push stop messages
          self.threads.times { passwords.push :stop }
        end

        valid_password = nil
        password_mutex = Mutex.new

        thread_pool = Array.new(self.threads) do
          Thread.new do
            session do |session|
              until password_mutex.synchronize { valid_password }
                password = passwords.pop

                # stop the thread, once we've ran out of passwords
                break if password == :stop

                if authenticate(session,username,password)
                  password_mutex.synchronize do
                    valid_password = password
                  end
                end
              end
            end
          end
        end

        thread_pool.each(&:join)

        if valid_password
          print_debug "Found #{username} :: #{valid_password}"
          yield username, valid_password
        end
      end

    end
  end
end
