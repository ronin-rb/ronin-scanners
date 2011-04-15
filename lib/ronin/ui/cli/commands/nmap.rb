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
        class Nmap < ScannerCommand

          desc 'Automates nmap scans and imports them into the Database'

          # The hosts or ranges to exclude from the scan.
          class_option :exclude, :default => Scanners::Nmap.exclude,
                                 :type => :string

          # The ports or port ranges which will be scanned.
          class_option :ports, :default => Scanners::Nmap.ports,
                               :type => :string,
                               :aliases => '-p'

          # Specifies that a Ping Scan will be performed.
          class_option :ping_scan, :default => Scanners::Nmap.ping_scan,
                                   :type => :boolean,
                                   :aliases => '-sP'

          # Specifies that a Connect Scan will be performed.
          class_option :connect_scan, :default => Scanners::Nmap.connect_scan,
                                      :type => :boolean,
                                      :aliases => '-sT'

          # Specifies that a TCP SYN scan will be performed.
          class_option :syn_scan, :default => Scanners::Nmap.syn_scan,
                                  :type => :boolean,
                                  :aliases => '-sS'

          # Specifies that a TCP ACK scan will be performed.
          class_option :ack_scan, :default => Scanners::Nmap.ack_scan,
                                  :type => :boolean,
                                  :aliases => '-sA'

          # Specifies that a TCP NULL scan will be performed.
          class_option :null_scan, :default => Scanners::Nmap.null_scan,
                                   :type => :boolean,
                                   :aliases => '-sN'

          # Specifies that a TCP FIN scan will be performed.
          class_option :fin_scan, :default => Scanners::Nmap.fin_scan,
                                  :type => :boolean,
                                  :aliases => '-sF'

          # Specifies that a TCP XMAS scan will be performed.
          class_option :xmas_scan, :default => Scanners::Nmap.xmas_scan,
                                   :type => :boolean,
                                   :aliases => '-sX'

          # Specifies that a UDP scan will be performed.
          class_option :udp_scan, :default => Scanners::Nmap.udp_scan,
                                  :type => :boolean,
                                  :aliases => '-sU'

          # Specifies that a Service scan will be performed.
          class_option :service_scan, :default => Scanners::Nmap.service_scan,
                                      :type => :boolean,
                                      :aliases => '-sV'

          # Specifies that an Idle Scan will be performed.
          class_option :idle_scan, :default => Scanners::Nmap.idle_scan,
                                   :type => :boolean,
                                   :aliases => '-sI'

          # Specifies that a Window Scan will be performed.
          class_option :window_scan, :default => Scanners::Nmap.window_scan,
                                     :type => :boolean,
                                     :aliases => '-sW'

          # Specifies whether to enable verbose output
          class_option :verbose, :default => Scanners::Nmap.verbose,
                                 :type => :boolean,
                                 :aliases => '-v'

          # The input file to read hosts/ports from
          class_option :import, :type => :string, :aliases => '-i'

          # The output file to write hosts/ports to
          class_option :output, :type => :string, :aliases => '-o -oX'

          # The hosts which will be scanned.
          argument :hosts, :required => true

          #
          # Runs the {Ronin::Scanners::Nmap} scanner.
          #
          # @since 1.0.0
          #
          def execute
            Database.setup

            @scanner = Scanners::Nmap.new
            @scanner.hosts = hosts
            @scanner.params = options

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
