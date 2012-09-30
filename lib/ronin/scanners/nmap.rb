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

require 'ronin/scanners/scanner'
require 'ronin/ip_address'
require 'ronin/port'
require 'ronin/service'

require 'nmap/task'
require 'nmap/program'
require 'nmap/xml'
require 'tempfile'

module Ronin
  module Scanners
    #
    # {Nmap} scans the open-ports found on the targeted IP addresses,
    # using the Nmap security / port scanner.
    #
    class Nmap < Scanner

      # The hosts which will be scanned.
      parameter :targets, :default => [],
                          :description => 'The hosts to scan with Nmap'

      # The hosts or ranges to exclude from the scan.
      parameter :exclude, :description => 'The hosts to exclude'

      # The ports or port ranges which will be scanned.
      parameter :ports, :description => 'The ports to scan'

      # Specifies that a Ping Scan will be performed.
      parameter :ping_scan, :default => false

      # Specifies that a Connect Scan will be performed.
      parameter :connect_scan, :default => true

      # Specifies that a TCP SYN scan will be performed.
      parameter :syn_scan, :default => false

      # Specifies that a TCP ACK scan will be performed.
      parameter :ack_scan, :default => false

      # Specifies that a TCP NULL scan will be performed.
      parameter :null_scan, :default => false

      # Specifies that a TCP FIN scan will be performed.
      parameter :fin_scan, :default => false

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

      # Enables paranoid-timing for nmap (`-T0`)
      parameter :paranoid_timing, :default => false

      # Enables sneaky-timing for nmap (`-T1`)
      parameter :sneaky_timing, :default => false

      # Enables polite-timing for nmap (`-T2`)
      parameter :polite_timing, :default => false

      # Enables normal-timing for nmap (`-T3`)
      parameter :normal_timing, :default => false

      # Enables aggressive-timing for nmap (`-T4`)
      parameter :aggressive_timing, :default => false

      # Enables insane-timing for nmap (`-T5`)
      parameter :insane_timing, :default => false

      # Specifies whether to resolve the IP Addresses.
      parameter :dns, :default => true

      # Specifies whether to enable verbose output
      parameter :verbose, :default => false

      # The input file to read hosts/ports from
      parameter :import_xml, :description => 'XML Scan file to import'

      # The output file to write hosts/ports to
      parameter :output, :description => 'XML Scan output file'

      protected

      #
      # Populates options to call `nmap` with.
      #
      # @yield [nmap]
      #   If a block is given, it will be passed the nmap options.
      #
      # @yieldparam [Nmap::Task] nmap
      #   The nmap options.
      #
      # @return [Nmap::Task]
      #   The populated nmap options.
      #
      # @since 1.0.0
      #
      def nmap_options
        nmap = ::Nmap::Task.new
        nmap.targets = self.targets

        nmap.exclude = self.exclude if self.exclude
        nmap.ports   = self.ports if self.ports

        nmap.paranoid_timing   = self.paranoid_timing
        nmap.sneaky_timing     = self.sneaky_timing
        nmap.polite_timing     = self.polite_timing
        nmap.normal_timing     = self.normal_timing
        nmap.aggressive_timing = self.aggressive_timing
        nmap.insane_timing     = self.insane_timing

        if self.ping_scan
          nmap.ping = self.ping_scan
        else
          nmap.connect_scan = self.connect_scan
          nmap.syn_scan     = self.syn_scan
          nmap.ack_scan     = self.ack_scan
          nmap.fin_scan     = self.fin_scan
          nmap.null_scan    = self.null_scan
          nmap.xmas_scan    = self.xmas_scan
          nmap.udp_scan     = self.udp_scan
          nmap.service_scan = self.service_scan
          nmap.idle_scan    = self.idle_scan
          nmap.window_scan  = self.window_scan
        end

        if self.dns? then nmap.enable_dns = true
        else              nmap.disable_dns = true
        end

        nmap.verbose = self.verbose

        return nmap
      end

      #
      # Sets up the scan output file for nmap.
      #
      # @yield [output]
      #   The block will be passed the output file.
      #
      # @yieldparam [String] output
      #   The path of the output file.
      #
      # @since 1.0.0
      #
      def nmap_output
        if self.output
          yield self.output
        else
          Tempfile.open('ronin_scanners_nmap') do |tempfile|
            yield tempfile.path
          end
        end
      end

      #
      # Performs a nmap scan and passes the scanned hosts to scanner rules.
      #
      # @yield [host]
      #   Every host that nmap scanned, will be passed to the given block.
      #
      # @yieldparam [Nmap::Host] host
      #   A host from the nmap scan.
      #
      # @see http://rubydoc.info/gems/ruby-nmap/Nmap/Host
      #
      # @since 1.0.0
      #
      def scan(&block)
        each_host = lambda { |path|
          ::Nmap::XML.new(path).each_host(&block)
        }

        if self.import_xml
          each_host.call(self.import_xml)
        else
          nmap_output do |path|
            options = nmap_options
            options.xml = path

            nmap = ::Nmap::Program.find()
            nmap.run_task(options)

            each_host.call(path)
          end
        end
      end

      #
      # Creates a new IP Address from a scanned host result.
      #
      # @param [Nmap::Host] host
      #   The scanned host.
      #
      # @return [IPAddress]
      #   The IP Address resource.
      #
      # @since 1.0.0
      #
      def new_ip(host)
        # if the host does not have an ip, then skip it
        return nil unless host.ip

        ip_version, ip_address = if    host.ipv6  then [6, host.ipv6]
                                 elsif host.ipv4  then [4, host.ipv4]
                                 end

        ip = IPAddress.first_or_new(
          :version => ip_version,
          :address => ip_address
        )

        if host.mac
          # fill in the MAC address
          ip.mac_addresses << MACAddress.first_or_new(:address => host.mac)
        end

        # fill in the host names
        host.each_hostname do |name|
          ip.host_names << HostName.first_or_new(:address => name)
        end

        return ip
      end

      #
      # Creates a new port from a scanned open port.
      #
      # @param [Nmap::Port] open_port
      #   The scanned open port.
      #
      # @return [Port]
      #   The port resource.
      #
      # @since 1.0.0
      #
      def new_port(open_port)
        Port.first_or_new(
          :protocol => open_port.protocol.to_s,
          :number   => open_port.number
        )
      end

      #
      # Creates a new service from the scanned open port.
      #
      # @param [Nmap::Port] open_port
      #   The scanned open port.
      #
      # @return [Service]
      #   The new service.
      #
      # @since 1.0.0
      #
      def new_service(open_port)
        if open_port.service
          Service.first_or_new(:name => open_port.service)
        end
      end

      #
      # Queries or creates an IPAddress resource from the given host.
      #
      # @param [Nmap::Host] result
      #   The host scanned by `nmap`.
      #
      # @return [IPAddress]
      #   The IPAddress resource from the Database.
      #
      # @since 1.0.0
      #
      def new_resource(result)
        return nil unless (ip = new_ip(result))

        # fill in the open ports
        result.each_open_port do |open_port|
          port    = new_port(open_port)
          service = new_service(open_port)

          # find or create a new open port
          new_open_port = ip.open_ports.first_or_new(:port => port)
          new_open_port.last_scanned_at = Time.now
          new_open_port.service = service
        end

        return ip
      end

    end
  end
end
