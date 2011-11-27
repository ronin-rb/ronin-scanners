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

require 'ronin/ui/cli/class_command'
require 'ronin/bruteforcers'

module Ronin
  module UI
    module CLI
      class BruteforcerCommand < ClassCommand

        class_namespace Bruteforcers

        class_option :database, :type    => :string,
                                :aliases => '-D',
                                :desc    => 'Ronin Database URI'

        class_option :all, :type    => :boolean,
                           :aliases => '-N',
                           :desc    => 'Bruteforce all usernames'

        class_option :import, :type    => :boolean,
                              :aliases => '-I',
                              :desc    => 'Save the credentials to the Database'

        class_option :wordlist, :type    => :string,
                                :aliases => '-w',
                                :banner  => 'FILE',
                                :desc    => 'Wordlist file to use'

        class_option :mutations, :type    => :hash,
                                 :aliases => '-m',
                                 :banner  => 'STRING:SUBSTITUTE',
                                 :desc    => 'Hash of mutations to perform'

        class_option :word_template, :type    => :hash,
                                     :aliases => '-g',
                                     :banner  => 'CHARSET:LEN[-LEN] [...]',
                                     :desc    => 'String generator template'

        class_option :username, :type    => :string,
                                :aliases => '-u',
                                :banner  => 'USER',
                                :desc    => 'Primary username to bruteforce'

        class_option :usernames, :type    => :array,
                                 :aliases => '-U',
                                 :banner  => 'USER [...]',
                                 :desc    => 'Additional user-names to try'

        class_option :min_words, :type    => :numeric,
                                 :aliases => '-m',
                                 :banner  => 'MIN',
                                 :desc    => 'Minimum number of words to use'

        class_option :max_words, :type    => :numeric,
                                 :aliases => '-M',
                                 :banner  => 'MAX',
                                 :desc    => 'Maximum number of words to use'

        class_option :threads, :type    => :numeric,
                               :default => 0,
                               :aliases => '-T',
                               :desc    => 'Number of Threads to use'

        protected

        alias bruteforcer object

        #
        # Sets up the credential scanner.
        #
        # @api semipublic
        #
        def setup
          super

          if (word_template = options[:word_template])
            bruteforcer.word_template = word_template.map do |charset,len|
              charset = charset.to_sym
              length  = if len.include?('-')
                          start, stop = length.split('-',2)

                          (start.to_i..stop.to_i)
                        else
                          length.to_i
                        end

              [charset, length]
            end
          end
        end

        def brute
          if options.import?
            method = if options.all?
                       :import_credentials
                     else
                       :import_credential
                     end

            printer = lambda { |credential|
              print_info "Found: #{credential.to_ary.join("\t")}"
            }
          else
            method = if options.all?
                       :bruteforce_all
                     else
                       :bruteforce
                     end

            printer = lambda { |*credentials|
              print_info "Found: #{credentials.join("\t")}"
            }
          end

          bruteforcer.send(method,&printer)
        end

      end
    end
  end
end
