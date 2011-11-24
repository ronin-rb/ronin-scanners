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

module Ronin
  module Bruteforcers
    class Bruteforce

      include Script

      # The primary-key of the bruteforcer
      property :id, Serial

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

      protected

      def bruteforce(username,password)
      end

      def single_threaded_bruteforce(username)
        each_password do |password|
          credential = begin
                         bruteforce(username,password)
                       rescue
                       end

          if credential
            yield credential
            break
          end
        end
      end

      def multi_threaded_bruteforce(username)
        credential_queue = Queue.new
        password_queue   = Queue.new

        thread_pool = Array.new(self.threads) do
          Thread.new do
            loop do
              password   = password_queue.pop
              credential = begin
                             bruteforce(username,password)
                           rescue
                           end

              if credential
                credential_queue.push credential
              end
            end
          end
        end

        password_thread = Thread.new do
          each_password do |password|
            break if thread_pool.all? { |thread| thread.stop? }

            password_queue.push password
          end
        end

        yield credential_queue.pop

        password_thread.stop
        thread_pool.each { |thread| thread.stop }
      end

    end
  end
end
