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
require 'ronin/scanners/nmap'

module Ronin
  module UI
    module CLI
      module Commands
        module Scanners
          class Nmap < ScannerCommand

            desc 'Automates nmap scans and imports them into the Database'

            # The hosts or ranges to exclude from the scan.
            scanner_option :exclude

            # The ports or port ranges which will be scanned.
            scanner_option :ports, :aliases => '-p'

            # Specifies that a Ping Scan will be performed.
            scanner_option :ping_scan, :aliases => '-sP'

            # Specifies that a Connect Scan will be performed.
            scanner_option :connect_scan, :aliases => '-sT'

            # Specifies that a TCP SYN scan will be performed.
            scanner_option :syn_scan, :aliases => '-sS'

            # Specifies that a TCP ACK scan will be performed.
            scanner_option :ack_scan, :aliases => '-sA'

            # Specifies that a TCP NULL scan will be performed.
            scanner_option :null_scan, :aliases => '-sN'

            # Specifies that a TCP FIN scan will be performed.
            scanner_option :fin_scan, :aliases => '-sF'

            # Specifies that a TCP XMAS scan will be performed.
            scanner_option :xmas_scan, :aliases => '-sX'

            # Specifies that a UDP scan will be performed.
            scanner_option :udp_scan, :aliases => '-sU'

            # Specifies that a Service scan will be performed.
            scanner_option :service_scan, :aliases => '-sV'

            # Specifies that an Idle Scan will be performed.
            scanner_option :idle_scan, :aliases => '-sI'

            # Specifies that a Window Scan will be performed.
            scanner_option :window_scan, :aliases => '-sW'

            # Specifies whether to enable verbose output
            scanner_option :verbose, :aliases => '-v'

            # The input file to read hosts/ports from
            scanner_option :import, :type => :string, :aliases => '-i'

            # The output file to write hosts/ports to
            scanner_option :output, :type => :string, :aliases => '-o -oX'

            # The hosts which will be scanned.
            argument :targets, :required => true

            #
            # Runs the {Ronin::Scanners::Nmap} scanner.
            #
            # @since 1.0.0
            #
            def execute
              print_info 'Saving scanned hosts and ports ...' if options.save?

              scan!

              print_info 'All scanned hosts and ports saved.' if options.save?
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
                  print_array host.each_address, :title => 'Addresses'
                  print_array host.each_hostname, :title => 'Hostname'
                end

                puts "[ Port ]\t[ State ]\t[ Service/Version ]\n"

                host.each_port do |port|
                  puts "  #{port}/#{port.protocol}\t  #{port.state}\t  #{port.service}"
                end
                puts
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

              print_array host.addresses.select { |address| address.new? },
                :title => 'Addresses'

              print_array host.ports.select { |port| port.new? },
                :title => 'Ports'

            end

          end
        end
      end
    end
  end
end
