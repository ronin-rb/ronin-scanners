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

require 'ronin/scanners/nmap_scanner'
require 'ronin/proxy'

module Ronin
  module Scanners
    #
    # The {ProxyScanner} scans known proxy ports and tests if they are running
    # a HTTP or SOCKS proxy.
    #
    class ProxyScanner < NmapScanner

      parameter :ports, :description => 'The ports to scan for proxies',
                        :default => [
                          80, 280, 443, 591, 593, 808, 3128, 5800..5803,
                          8008, 8080, 8888, 8443, 9050, 9999
                        ]

      protected

      #
      # Scans the given ports for proxies.
      #
      # @yield [proxy]
      #   The given block will be passed valid proxies.
      #
      # @yieldparam [Proxy]
      #   A tested and working proxy.
      #
      # @since 0.2.0
      #
      def scan
        super do |host|
          host.each_open_port do |open_port|
            type = case open_port.service
                       when /SOCKS/i
                         'socks'
                       when /HTTP/i
                         'http'
                       else
                         # skip unidentifiable proxies
                         next
                       end

            ip = new_ip(host)
            port = new_port(open_port)

            proxy = Proxy.first_or_new(:ip_address => ip, :port => port)
            proxy.type = type

            yield proxy if proxy.test
          end
        end
      end

      #
      # Normalizes a proxy.
      #
      # @param [Proxy] proxy
      #   The proxy.
      #
      # @return [Proxy]
      #   The normalized proxy.
      #
      # @since 0.2.0
      #
      def new_resource(proxy)
        proxy
      end

    end
  end
end
