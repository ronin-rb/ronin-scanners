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
require 'ronin/scanners/nmap'

module Ronin
  module UI
    module CLI
      module Commands
        module Scan
          class Nmap < ScannerCommand

            summary 'Automates nmap scans and imports them into the Database'

            #
            # Runs the {Ronin::Scanners::Nmap} scanner.
            #
            # @since 1.0.0
            #
            def execute
              print_info 'Saving scanned hosts and ports ...' if import?

              scan

              print_info 'All scanned hosts and ports saved.' if import?
            end

            protected

            #
            # Prints a scanned host result.
            #
            # @param [Nmap::Host] host
            #   A scanned host.
            #
            # @since 1.0.0
            #
            def print_result(host)
              puts

              print_hash({
                :started => host.start_time,
                :ended => host.end_time,
                :status => "#{host.status.state} (#{host.status.reason})"
              }, :title => host)

              indent do
                if options.verbose?
                  print_array host.each_address,  :title => 'Addresses'
                  print_array host.each_hostname, :title => 'Hostname'
                end

                puts "[ Port ]\t[ State ]\t[ Service/Version ]"
                spacer

                host.each_port do |port|
                  puts "  #{port}/#{port.protocol}\t  #{port.state}\t  #{port.service}"
                end

                spacer
              end
            end

            #
            # Prints a saved host.
            #
            # @param [IPAddress] host
            #   A saved host.
            #
            # @since 1.0.0
            #
            def print_resource(host)
              print_info "Saving #{host}:"
              print_info 'Addresses:'

              print_array host.addresses.select(&:new?), :title => 'Addresses'
              print_array host.ports.select(&:new?),     :title => 'Ports'
            end

          end
        end
      end
    end
  end
end
