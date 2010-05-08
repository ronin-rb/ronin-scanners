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
require 'ronin/host_name'

module Ronin
  module Scanners
    #
    # The {HostNameScanner} class represents scanners that yield host-name
    # results and `HostName` resources.
    #
    class HostNameScanner < Scanner

      contextify :ronin_host_name_scanner

      protected

      #
      # Normalizes the host name.
      #
      # @param [Object] result
      #   The incoming host name.
      #
      # @return [String]
      #   The normalized host name.
      #
      # @since 0.2.0
      #
      def normalize_result(result)
        result.to_s
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
        HostName.first_or_new(:address => result)
      end

    end
  end
end
