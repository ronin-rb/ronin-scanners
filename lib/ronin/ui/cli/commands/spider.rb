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

require 'ronin/ui/cli/scanner_command'
require 'ronin/scanners/spider'

module Ronin
  module UI
    module CLI
      module Commands
        class Spider < ScannerCommand

          desc 'Spiders a website and saves URLs into the Database'

          class_option :start_at, :type => :string, :aliases => '-s'
          argument :hosts, :type => :array

          #
          # Spider one or more websites.
          #
          # @since 1.0.0
          #
          def execute
            print_info 'Saving spidered URLs ...' if options.save?

            scan!

            print_info 'All spidered URLs saved.' if options.save?
          end

          protected

          #
          # Prints a spidered page.
          #
          # @param [Spidr::Page] page
          #   A spidered page.
          #
          # @since 1.0.0
          #
          def print_result(page)
            print_info page.url

            if options.verbose?
              print_hash page.headers
              puts page.body
            end
          end

        end
      end
    end
  end
end
