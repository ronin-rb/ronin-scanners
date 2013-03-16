#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2013 Hal Brodigan (postmodern.mod3 at gmail.com)
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
require 'ronin/network/http/http'

require 'net/http/persistent'

module Ronin
  module Scanners
    #
    # The {HTTPScanner} class represents a scanner that performs
    # HTTP Requests inorder to discover URLs.
    #
    # @since 1.0.0
    #
    class HTTPScanner < URLScanner

      protected

      #
      # The [net-http-persistent](http://seattlerb.rubyforge.org/net-http-persistent/)
      # client.
      #
      # @return [Net::HTTP::Persistent]
      #   The client.
      #
      # @see http://seattlerb.rubyforge.org/net-http-persistent/
      #
      # @api semipublic
      #
      def http
        @http ||= Net::HTTP::Persistent.new
      end

      #
      # Performs an HTTP Request through a persistent connection.
      #
      # @param [Hash] options
      #   HTTP options.
      #
      # @return [Net::HTTPResponse]
      #
      # @api semipublic
      #
      def http_request(options={})
        options = Network::HTTP.normalize_options(options)
        uri_class = if options[:ssl] then URI::HTTPS
                    else                  URI::HTTP
                    end

        uri = uri_class.build(
          host: options[:host],
          port: options[:port]
        )
        request = Network::HTTP.request(options)

        return http.request(uri,request)
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_copy(options={})
        http_request(options.merge(method: :copy))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_delete(url,options={})
        http_request(options.merge(method: :delete))
      end

      def http_get(url,options={})
        http_request(options.merge(method: :get))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_head(url,options={})
        http_request(options.merge(method: :head))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_lock(url,options={})
        http_request(options.merge(method: :lock))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_mkcol(url,options={})
        http_request(options.merge(method: :mkcol))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_move(url,options={})
        http_request(options.merge(method: :move))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_options(url,options={})
        http_request(options.merge(method: :options))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_post(url,options={})
        http_request(options.merge(method: :post))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_prop_find(url,options={})
        http_request(options.merge(method: :prop_find))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_prop_patch(url,options={})
        http_request(options.merge(method: :prop_patch))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_trace(url,options={})
        http_request(options.merge(method: :trace))
      end

      #
      # @see #http_request
      #
      # @api semipublic
      #
      def http_unlock(url,options={})
        http_request(options.merge(method: :unlock))
      end

    end
  end
end
