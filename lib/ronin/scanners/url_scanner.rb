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
require 'ronin/extensions/uri'
require 'ronin/url'

require 'uri'

module Ronin
  module Scanners
    #
    # The {URLScanner} class represents scanners that yield `URI` results
    # and `URL` resources.
    #
    class URLScanner < Scanner

      contextify :ronin_url_scanner

      protected

      #
      # Normalizes the URL.
      #
      # @param [String, URI::Generic] result
      #   The incoming URL.
      #
      # @return [URI::Generic]
      #   The normalized URI.
      #
      # @since 0.2.0
      #
      def normalize_result(result)
        unless result.kind_of?(::URI::Generic)
          URI(result.to_s)
        else
          result
        end
      end

      #
      # Queries or creates a new Url resource for the given result.
      #
      # @param [URI::Generic] result
      #   The URL.
      #
      # @return [Url]
      #   The Url resource from the Database.
      #
      # @since 0.2.0
      #
      def new_resource(result)
        URL.first_or_new(
          :scheme => result.scheme,
          :host_name => HostName.first_or_new(
            :address => result.host
          ),
          :port => TCPPort.first_or_new(
            :number => result.port,
            :protocol => 'tcp'
          ),
          :path => result.path,
          :query_string => result.query
        )
      end

    end
  end
end
