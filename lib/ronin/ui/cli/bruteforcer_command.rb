#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
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

        option :database, :type => String,
                          :flag => '-D',
                          :description => 'Ronin Database URI'

        option :all, :type => true,
                     :flag => '-N',
                     :description => 'Bruteforce all usernames'

        option :import, :type => true,
                        :flag => '-I',
                        :description => 'Save the credentials to the Database'

        alias bruteforcer object

        protected

        #
        # Sets up the credential scanner.
        #
        # @api semipublic
        #
        def setup
          super

          if bruteforcer.word_template?
            bruteforcer.word_template.map! do |template|
              charset, lengths = template.split(':',2)

              charset = charset.to_sym
              length  = if lengths.include?('-')
                          start, stop = lengths.split('-',2)

                          (start.to_i..stop.to_i)
                        else
                          lengths.to_i
                        end

              [charset, length]
            end
          end
        end

        def brute
          if import?
            method = if all?
                       :import_credentials
                     else
                       :import_credential
                     end

            printer = lambda { |credential|
              print_info "Found: #{credential.to_ary.join("\t")}"
            }
          else
            method = if all?
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
