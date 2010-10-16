#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
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
require 'ronin/network/http'

require 'spidr/agent'

module Ronin
  module Scanners
    #
    # The {WebSpider} class represents scanners that spider web pages,
    # yielding `Spidr::Page` results and `URL` resources.
    #
    class WebSpider < URLScanner

      #
      # Creates a new web scanner object.
      #
      # @yield []
      #   The given block will be used to create a new web scanner object.
      #
      # @return [WebScanner]
      #   The new web scanner object.
      #
      # @example
      #   ronin_web_spider do
      #     cache do
      #       self.name = 'some web scanner'
      #       self.description = %{
      #         This is an example web scanner.
      #       }
      #     end
      #
      #     protected
      #
      #     def scan
      #       super do |page|
      #         # ...
      #       end
      #     end
      #   end
      #
      # @since 0.2.0
      #
      contextify :ronin_web_spider

      # The URL to start spidering at.
      parameter :start_at, :type => URI::HTTP,
                           :description => 'The URI to start scanning at'

      # The hosts to spider.
      parameter :hosts, :default => Set[],
                        :description => 'The hosts to scan'

      #
      # Creates a new web spider agent.
      #
      # @yield [agent]
      #   The given block will be passed the newly created web spider
      #   agent.
      #
      # @yieldparam [Spidr::Agent] agent
      #   The newly created web spider agent to configure.
      #
      # @return [Spidr::Agent]
      #   The newly created web spider agent.
      #
      # @since 0.2.0
      #   
      def agent(&block)
        options = {
          :proxy => Network::HTTP.proxy,
          :user_agent => Network::HTTP.user_agent
        }

        return Spidr::Agent.new(options,&block)
      end

      protected

      #
      # Begins spidering web pages.
      #
      # @yield [page]
      #   The given block will be passed each spidered web page.
      #
      # @yieldparam [Spidr::Page] page
      #   A page visited by the web spider.
      #
      # @since 0.2.0
      #
      def scan(&block)
        spider = agent()

        spider.start_at(self.start_at,&block)
      end

      #
      # Normalizes a visited web page.
      #
      # @param [Spidr::Page] page
      #   A visited web page.
      #
      # @return [Spidr::Page]
      #   The visited web page.
      #
      # @since 0.2.0
      #
      def normalize_result(page)
        page
      end

      #
      # Converts a visited web page into a URL resource.
      #
      # @param [Spidr::Page] page
      #   A visited web page.
      #
      # @return [URL]
      #   The URL resource for the web page.
      #
      # @since 0.2.0
      #
      def new_resource(page)
        super(page.uri)
      end

    end
  end
end
