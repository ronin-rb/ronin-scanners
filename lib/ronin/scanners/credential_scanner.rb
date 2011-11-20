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

require 'ronin/extensions/file'
require 'ronin/scanners/scanner'
require 'ronin/credential'
require 'ronin/wordlist'

module Ronin
  module Scanners
    #
    # The {CredentialScanner} class represents scanners that yield
    # `Credential` results and resources.
    #
    # @since 1.0.0
    #
    class CredentialScanner < Scanner

      # Paths to the wordlist file or list of words.
      parameter :wordlist, :description => 'Wordlist file or list of words'

      # Mutation rules to apply to words from the {#wordlist}
      parameter :mutations, :default     => {},
                            :description => 'Hash of mutations to perform'

      # Word generator template
      parameter :word_template, :type        => Array,
                                :description => 'String generator template'

      # Primary username to use
      parameter :username, :type        => String,
                           :description => 'Primary username to use'

      # Additional user-names to try
      parameter :usernames, :type        => Array[String],
                            :default     => [],
                            :description => 'Additional user-names to try'

      # Minimum number of words to combine
      parameter :min_words, :type        => Integer,
                            :default     => 1,
                            :description => 'Minimum number of words to use'

      # Maximum number of words to combine
      parameter :max_words, :type        => Integer,
                            :default     => 1,
                            :description => 'Maximum number of words to use'

      protected

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
      # @api semipublic
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
      def each_password(&block)
        each_word(&block)
      end

      #
      # Itereates over every credential.
      #
      # @yield [username, password]
      #   The given block will be passed every user-name and password
      #   combination.
      #
      # @yieldparam [String] username
      #   A possible user-name.
      #
      # @yieldparam [String] password
      #   A generated password.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      def each_credential
        return enum_for(:each_credential) unless block_given?

        each_username do |username|
          each_password do |password|
            yield username, password
          end
        end
      end

      #
      # Normalizes results from the Credential Scanner.
      #
      # @param [Object] result
      #   A result from the Credential Scanner.
      #
      # @return [Hash]
      #   A hash containing the `:username` and `:password` keys.
      #
      def normalize_result(result)
        if result.kind_of?(Hash)
          if (result.has_key?(:username) && result.has_key?(:password))
            result
          end
        end
      end

      #
      # Creates a new resource from a result.
      #
      # @param [Hash] result
      #   A hash containing the `:username` and `:password` keys.
      #   The optional `:email_address` key is also respected.
      #
      # @return [Credential]
      #   A credential resource.
      #
      def new_resource(result)
        Credential.first_or_new(
          :user_name     => UserName.parse(result[:username]),
          :password      => Password.parse(result[:password]),

          :email_address => if result[:email_address]
                              EmailAddress.parse(result[:email_address])
                            end
        )
      end

    end
  end
end
