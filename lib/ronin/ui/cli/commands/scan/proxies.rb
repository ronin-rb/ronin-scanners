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

require 'ronin/ui/cli/scanner_command'
require 'ronin/scanners/proxies'

module Ronin
  module UI
    module CLI
      module Commands
        module Scan
          class Proxies < ScannerCommand

            summary 'Scans for proxies and imports them into the Database'

            #
            # Runs the nmap scanner.
            #
            # @since 1.0.0
            #
            def execute
              print_info 'Saving scanned proxies ...' if import?

              scan

              print_info 'All scanned proxies saved.' if import?
            end

            protected

            #
            # Prints a scanned proxy.
            #
            # @param [Proxy] proxy
            #   A scanned proxy.
            #
            # @since 1.0.0
            #
            def print_result(proxy)
              print_hash({
                :type => proxy.type,
                :anonymous => proxy.anonymous?,
                :latency => proxy.latency
              }, :title => proxy.ip_address)
            end

            #
            # Prints a saved proxy.
            #
            # @param [Proxy] proxy
            #   A saved proxy.
            #
            # @since 1.0.0
            #
            def print_resource(proxy)
              print_result(proxy)
            end

          end
        end
      end
    end
  end
end
