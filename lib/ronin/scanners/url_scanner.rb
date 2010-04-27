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

require 'ronin/scanner/scanner'
require 'ronin/extensions/uri'
require 'ronin/int/url'

require 'uri'

module Ronin
  module Scanners
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
      def normalize_result(result)
        unless result.kind_of?(URI::Generic)
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
      # @return [INT::Url]
      #   The Url resource from the Database.
      #
      def new_resource(result)
        INT::Url.first_or_new(
          :schema => result.schema,
          :host_name => INT::HostName.first_or_new(
            :address => result.host
          ),
          :port => INT::TcpPort.first_or_new(
            :number => result.port,
            :protocol => 'tcp'
          ),
          :path => result.path,
          :query => result.query
        )
      end

    end
  end
end
