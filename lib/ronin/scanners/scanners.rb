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

require 'open_namespace'

module Ronin
  module Scanners
    include OpenNamespace

    #
    # Performs an nmap scan.
    #
    # @param [Hash] options
    #   Options to pass to {Nmap}.
    #
    # @yield [host]
    #   The given block will be passed each scanned IP Address.
    #
    # @yieldparam [IPAddress] host
    #   A scanned IP Address.
    #
    # @return [Array<IPAddress>]
    #   If no block is given, an Array of scanned IP Addresses will be returned.
    #
    # @see Nmap
    #
    # @api public
    #
    def Scanners.nmap(options={},&block)
      nmap = Nmap.new
      nmap.params = options

      if block
        nmap.each_resource(&block)
      else
        nmap.each_resource.to_a
      end
    end
  end
end
