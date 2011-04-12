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

require 'ronin/scanners/host_name_scanner'

require 'resolv'

module Ronin
  module Scanners
    #
    # The {ReverseLookupScanner} scans the host-name(s) associated with
    # an IP address.
    #
    class ReverseLookupScanner < HostNameScanner

      parameter :host, :description => 'The IP address to reverse lookup'

      protected

      #
      # Performs a reverse lookup on an IP address.
      #
      # @yield [host]
      #   The host name associated with the IP address.
      #
      # @yieldparam [String] host
      #   A host name associated with the IP address.
      #
      # @since 0.2.0
      #
      def scan(&block)
        Resolv.getnames(self.host).each(&block)
      end

      #
      # Queries or creates a new HostName resource for the result.
      #
      # @param [String] result
      #   The host name.
      #
      # @return [HostName]
      #   The HostName resource from the Database.
      #
      # @since 0.2.0
      #
      def new_resource(result)
        # get a host name
        host_name = HostName.first_or_new(:address => result)

        # associate the host name with the IP address we are looking up
        host_name.ip_addresses.first_or_new(:address => self.host.to_s)

        return host_name
      end

    end
  end
end
