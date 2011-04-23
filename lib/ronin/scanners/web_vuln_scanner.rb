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

require 'ronin/scanners/scanner'
require 'ronin/vulns/web'

require 'uri'

module Ronin
  module Scanners
    #
    # The {WebVulnScanner} class represents scanners that yields
    # `Vulns::Web` resources.
    #
    class WebVulnScanner < Scanner

      protected

      #
      # Normalizes the web vulnerability.
      #
      # @param [Vulns::Web] vuln
      #   The web vulnerability.
      #
      # @return [Vulns::Web]
      #   The web vulnerability.
      #
      # @since 1.0.0
      #
      def normalize_result(vuln)
        vuln if vuln.kind_of?(Vulns::Web)
      end

      #
      # Prepares the web vulnerability to be saved into the Database.
      #
      # @param [Vulns::Web] vuln
      #   The web vulnerability.
      #
      # @return [Vulns::Web]
      #   The web vulnerability.
      #
      # @since 1.0.0
      #
      def new_resource(vuln)
        vuln
      end

    end
  end
end
