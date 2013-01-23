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

require 'ronin/scanners/url_scanner'
require 'ronin/network/mixins/http'

require 'nokogiri'

module Ronin
  module Scanners
    #
    # The {SiteMap} scans the URLs listed in a websites `sitemap.xml` file.
    #
    class SiteMap < URLScanner

      include Network::Mixins::HTTP

      # The path to the sitemap
      SITEMAP_PATH = '/sitemap.xml'

      protected

      #
      # Requests `sitemap.xml` from a host and parses the URLs.
      #
      # @yield [url]
      #   The given block will be passed every URL within the sitemap.
      #
      # @yieldparam [String] url
      #   One of the URLs from the sitemap.
      #
      # @since 1.0.0
      #
      def scan
        sitemap = Nokogiri::XML(http_get_body(path: SITEMAP_PATH))

        sitemap.search('/urlset/url/loc/.').each do |url|
          yield url
        end
      end

    end
  end
end
