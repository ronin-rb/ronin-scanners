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
require 'ronin/open_port'

module Ronin
  module Scanners
    #
    # The {UDPPortScanner} class represents scanners that yield UDP port
    # number results and `OpenPort` resources.
    #
    class UDPPortScanner < Scanner

      protected

      #
      # Normalizes the port number.
      #
      # @param [String, Integer] result
      #   The incoming port number.
      #
      # @return [Integer]
      #   The normalized port number.
      #
      # @since 0.2.0
      #
      def normalize_result(result)
        result.to_i
      end

      #
      # Queries or creates a new open-port resource for the given result.
      #
      # @param [Integer] result
      #   The port number.
      #
      # @return [OpenPort]
      #   The open port resource from the Database.
      #
      # @since 0.2.0
      #
      def new_resource(result)
        OpenPort.first_or_new(
          port: Port.first_or_new(
            protocol: 'udp',
            number:   result
          )
        )
      end

    end
  end
end
