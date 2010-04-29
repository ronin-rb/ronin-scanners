#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/scanners/scanner'

require 'nmap/task'
require 'nmap/program'
require 'nmap/xml'
require 'tempfile'

module Ronin
  module Scanners
    class NmapScanner < Scanner

      contextify :ronin_nmap_scanner

      # The targets which will be scanned.
      parameter :targets, :default => [],
                          :description => 'The targets to scan with Nmap'

      # The targets or ranges to exclude from the scan.
      parameter :exclude, :default => [],
                          :description => 'The targets to exclude'

      # The ports or port ranges which will be scanned.
      parameter :ports, :default => [],
                        :description => 'The ports to scan'

      # Specifies that a Ping Scan will be performed.
      parameter :ping, :default => true

      # Specifies that a Connect Scan will be performed.
      parameter :connect_scan, :default => true

      # Specifies that a TCP SYN scan will be performed.
      parameter :syn_scan, :default => false

      # Specifies that a TCP ACK scan will be performed.
      parameter :ack_scan, :default => false

      # Specifies that a TCP NULL scan will be performed.
      parameter :null_scan, :default => false

      # Specifies that a TCP FIN scan will be performed.
      parameter :fin_scam, :default => false

      # Specifies that a TCP XMAS scan will be performed.
      parameter :xmas_scan, :default => false

      # Specifies that a UDP scan will be performed.
      parameter :udp_scan, :default => false

      # Specifies that a Service scan will be performed.
      parameter :service_scan, :default => true

      # Specifies that an Idle Scan will be performed.
      parameter :idle_scan, :default => false

      # Specifies that a Window Scan will be performed.
      parameter :window_scan, :default => false

      # Specifies that a Mainmon Scan will be performed.
      parameter :maimon_scam, :default => false

      #
      # The path to the `nmap` utility.
      #
      # @return [String, nil]
      #   The path to the `nmap` utility.
      #
      def NmapScanner.path
        @@nmap_program_path
      end

      #
      # Sets the path to the `nmap` utility.
      #
      # @param [String] new_path
      #   The path to the `nmap` utility.
      #
      # @return [String]
      #   The new path to the `nmap` utility.
      #
      def NmapScanner.path=(new_path)
        @@nmap_program_path = File.expand_path(new_path)
      end

      protected

      #
      # Performs a nmap scan and passes the scanned hosts to scanner rules.
      #
      # @yield [host]
      #   Every host that nmap scanned, will be passed to the given block.
      #
      # @yieldparam [Nmap::Host] host
      #   A host from the nmap scan.
      #
      def scan(&block)
        Tempfile.open('ronin_scanners_nmap') do |tempfile|
          options = Nmap::Task.new do |nmap|
            # set the nmap options en-mass using the parameters
            self.params.each do |name,param|
              nmap.options[name] = param.value
            end

            # set the xml output path
            nmap.xml = tempfile.path
          end

          nmap = if NmapScanner.path
                   # use the previously specified path to nmap
                   Nmap::Program.new(NmapScanner.path)
                 else
                   # find nmap
                   Nmap::Program.find()
                 end

          # run nmap
          nmap.run_task(options)

          # enumerate the scanned hosts
          Nmap::XML.new(tempfile.path).each_host(&block)
        end
      end

      #
      # Queries or creates an IPAddress resource from the given host.
      #
      # @param [Nmap::Host] result
      #   The host scanned by `nmap`.
      #
      # @return [INT::IPAddress]
      #   The IPAddress resource from the Database.
      #
      def new_resource(result)
        # if the host does not have an ip, then skip it
        return nil unless result.ip

        ip_version, ip_address = if result.ipv6
                                   [6, result.ipv6]
                                 elsif result.ipv4
                                   [4, result.ipv4]
                                 end

        ip = INT::IPAddress.first_or_new(
          :version => ip_version,
          :address => ip_address
        )

        # fill in the MAC address
        ip.mac_addresses.first_or_new(:address => result.mac)

        # fill in the host names
        result.each_hostname do |name|
          ip.hostnames.first_or_new(:address => name)
        end

        # fill in the open ports
        result.each_open_port do |open_port|
          # find or create the port
          port = INT::Port.first_or_new(
            :protocol => open_port.protocol.to_s,
            :number => open_port.number
          )

          # find or create the service, if the port has a service
          service = if open_port.service
                      INT::Service.first_or_new(:name => open_port.service)
                    end

          # find or create the open port
          ip.open_ports.first_or_new(:port => port, :service => service)
        end

        return ip
      end

    end
  end
end
