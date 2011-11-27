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
require 'ronin/scanners/proxies'

module Ronin
  module UI
    module CLI
      module Commands
        module Scanners
          class Proxies < ScannerCommand

            desc 'Scans for proxies and saves them into the Database'

            # The hosts or ranges to exclude from the scan.
            param_option :exclude

            # The ports or port ranges which will be scanned.
            param_option :ports, :aliases => '-p'

            # Specifies whether to enable verbose output
            param_option :verbose, :aliases => '-v'

            # The hosts which will be scanned.
            argument :hosts, :required => true

            #
            # Runs the nmap scanner.
            #
            # @since 1.0.0
            #
            def execute
              print_info 'Saving scanned proxies ...' if options.save?

              scan!

              print_info 'All scanned proxies saved.' if options.save?
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
