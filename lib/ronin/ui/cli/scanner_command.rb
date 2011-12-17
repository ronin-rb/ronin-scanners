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
require 'ronin/scanners'
require 'ronin/database'

module Ronin
  module UI
    module CLI
      class ScannerCommand < ClassCommand

        class_namespace Scanners

        option :database, :type => String, :flag => '-D'
        option :first, :type => Integer, :flag => '-N'
        option :import, :type => true, :flag => '-I'

        alias scanner object

        #
        # Invokes the scanner.
        #
        # @see #scan!
        #
        # @api semipublic
        #
        def execute
          scan
        end

        protected

        #
        # Sets up the scanner command.
        #
        # @api semipublic 
        #
        def setup(*arguments)
          if database?
            Database.repositories[:default] = @database
          end

          Database.setup

          super(*arguments)
        end

        #
        # Performs a scan using the `@scanner` instance variable.
        #
        # @since 1.0.0
        #
        def scan
          enum, printer = if import?
                            [scanner.import, method(:print_resource)]
                          else
                            [scanner.each, method(:print_result)]
                          end

          first_n = (@first || Float::INFINITY)
          count   = 0

          enum.each do |result|
            count += 1

            printer.call(result)

            break if count >= first_n
          end
        end

        #
        # Displays a result from the scanner.
        #
        # @param [Object] result
        #   A result yielded from the scanner.
        #
        # @since 1.0.0
        #
        def print_result(result)
          puts result
        end

        #
        # Displays a resource from the scanner.
        #
        # @param [Model] resource
        #   A resource yielded from the scanner.
        #
        # @since 1.0.0
        #
        def print_resource(resource)
          puts resource
        end

      end
    end
  end
end
