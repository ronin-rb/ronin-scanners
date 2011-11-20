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

require 'ronin/script'

module Ronin
  module Scanners
    #
    # The {Scanner} base class allows for defining various types of
    # scanners. All scanners are Enumerable, have Parameters and are
    # Cacheable.
    #
    # # Metadata
    #
    # A {Scanner} can be described by metadata, which is cached into the
    # Ronin Database. The cacheable metadata must be defined within a
    # `cache` block, so that the metadata is set only before the scanner
    # is cached:
    #
    #     cache do
    #       self.name = 'ZIP Scanner'
    #       self.description = %{
    #         A scanner which finds ZIP files on a system.
    #       }
    #     end
    #
    # ## License
    #
    # A {Scanner} may be associated with a specific software license using
    # the `license!` method:
    # 
    #     cache do
    #       # ...
    #
    #       self.license! :mit
    #     end
    #
    # # Methods
    #
    # The primary method which will perform the scanning and yielding back
    # of results is {#scan}.
    #
    # The {Scanner} class defines three other methods for enumerating
    # results using {#scan}:
    #
    # * {#each} - enumerates over the normalized results, using
    #   {#normalize_result} to normalize the results.
    # * {#each_resource} - enumerates over resources that were
    #   created from the results, using {#new_resource}.
    # * {#import} - saves the resources into the Database, while
    #   enumerating over the resources.
    #
    # # Scanner Base Classes
    #
    # * {IPScanner}
    # * {HostNameScanner}
    # * {TCPPortScanner}
    # * {UDPPortScanner}
    # * {URLScanner}
    # * {CredentialScanner}
    # * {ServiceCredentialScanner}
    #
    # # Specialized Scanner Classes
    #
    # * {ResolvScanner}
    # * {ReverseLookupScanner}
    # * {SiteMap}
    # * {Spider}
    # * {Nmap}
    # * {Proxies}
    # * {DB}
    #
    class Scanner

      include Script
      include Enumerable

      # The primary-key of the scanner
      property :id, Serial

      #
      # Creates a new {Scanner} object.
      #
      # @param [Hash] options
      #   Additional options for the scanner.
      #
      # @since 1.0.0
      #
      def initialize(options={})
        super(options)

        initialize_params(options)
      end

      #
      # Initializes the scanner and performs a scan.
      #
      # @param [Hash] options
      #   Options for the scanner.
      #
      # @yield [resource]
      #   The given block will be passed every scanned resource.
      #
      # @yieldparam [DataMapper::Resource] resource
      #   A resource found by the scanner.
      #
      # @return [Array<DataMapper::Resource>]
      #   If no block is given, an Array of scanned resources will be returned.
      #
      # @see #each_resource
      #
      # @since 1.0.0
      #
      # @api public
      #
      def self.scan(options={},&block)
        scanner = new(options)

        if block
          scanner.each_resource(&block)
        else
          scanner.each_resource.to_a
        end
      end

      #
      # Performs the scan.
      #
      # @yield [result]
      #   The given block will be passed each "result" from the scan.
      #
      # @yieldparam [Object] result
      #   A "result" from the scan.
      #
      # @return [Scanner, Enumerator]
      #   If no block was given, an `Enumerator` object will be returned.
      #
      # @since 1.0.0
      #
      def each
        return enum_for(:each) unless block_given?

        scan do |result|
          if result
            if (result = normalize_result(result))
              yield result
            end
          end
        end

        return self
      end

      #
      # Creates new resource objects from the scan results.
      #
      # @yield [resource]
      #   The given block will be passed each resource.
      #
      # @yieldparam [DataMapper::Resource] resource
      #   A new or pre-existing resource.
      #
      # @return [Scanner, Enumerator]
      #   If no block was given, an `Enumerator` object will be returned.
      #
      # @since 1.0.0
      #
      def each_resource
        return enum_for(:each_resource) unless block_given?

        scan do |result|
          if result
            if (result = normalize_result(result))
              if (resource = new_resource(result))
                yield resource
              end
            end
          end
        end
      end

      #
      # Imports the scan results into the Database.
      #
      # @yield [resource]
      #   The given block will be passed each resource, after it has
      #   been saved into the Database.
      #
      # @yieldparam [DataMapper::Resource] resource
      #   A resource that exists in the Database.
      #
      # @return [Scanner, Enumerator]
      #   If no block was given, an `Enumerator` object will be returned.
      #
      # @since 1.0.0
      #
      def import
        return enum_for(:import) unless block_given?

        each_resource do |resource|
          yield resource if resource.save
        end
      end

      #
      # Runs the scanner.
      #
      # @see #each
      #
      # @since 1.0.0
      #
      def run
        print_info "Scanning ..."

        each do |result|
          print_info "Found #{result}"
          yield result if block_given?
        end

        print_info "Scan complete."
      end

      protected

      #
      # The default method which normalizes results.
      #
      # @param [Object] result
      #   The incoming result.
      #
      # @return [Object]
      #   The normalized result.
      #
      # @since 1.0.0
      #
      def normalize_result(result)
        result
      end

      #
      # Creates a new Database resource.
      #
      # @param [Object] result
      #   A result from the scan.
      #
      # @return [DataMapper::Resource, nil]
      #   The resource created from the result, or `nil` if a resource
      #   could not be created from the result.
      #
      # @since 1.0.0
      #
      def new_resource(result)
        nil
      end

      #
      # The default method which will actually perform the scanning.
      #
      # @since 1.0.0
      #
      def scan(&block)
      end

    end
  end
end
