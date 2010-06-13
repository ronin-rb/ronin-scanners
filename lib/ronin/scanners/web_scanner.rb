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
    class WebScanner < URLScanner

      parameter :start_at, :type => URI::HTTP,
                           :description => 'The URI to start scanning at'

      parameter :hosts, :default => Set[],
                        :description => 'The hosts to scan'

      def agent(&block)
        options = {
          :proxy => Network::HTTP.proxy,
          :user_agent => Network::HTTP.user_agent
        }

        return Spidr::Agent.new(options,&block)
      end

      protected

      def scan(&block)
        spider = agent()

        spider.start_at(self.start_at,&block)
      end

      def normalize_result(page)
        page
      end

      def new_resource(page)
        super(page.uri)
      end

    end
  end
end
