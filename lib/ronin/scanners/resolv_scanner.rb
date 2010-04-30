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

require 'ronin/scanners/ip_scanner'

require 'resolv'

module Ronin
  module Scanners
    class ResolvScanner < IPScanner

      parameter :host, :description => 'The host to resolv'

      protected

      #
      # Resolvs the IP addresses for the host.
      #
      # @yield [ip]
      #   The given block will be passed each IP address associated with the
      #   host.
      #
      # @yieldparam [String] ip
      #   An IP address of the host.
      #
      def scan(&block)
        Resolv.getaddresses(self.host).each(&block)
      end

      #
      # Queries or creates a new IPAddress resource for the given result.
      #
      # @param [IPAddr] result
      #   The ip address.
      #
      # @return [IPAddress]
      #   The IPAddress resource from the Database.
      #
      def new_resource(result)
        # get an IP address
        ip = IPAddress.first_or_new(:address => result)

        # associate the IP address with the host we are resolving
        ip.host_names.first_or_new(:address => self.host.to_s)

        return ip
      end

    end
  end
end
