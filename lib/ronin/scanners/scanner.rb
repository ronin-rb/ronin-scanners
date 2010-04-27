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

require 'ronin/platform/cacheable'
require 'ronin/model/has_name'
require 'ronin/model/has_description'
require 'ronin/model/has_license'

require 'parameters'

module Ronin
  module Scanners
    class Scanner

      include Enumerable
      include Parameters
      include Platform::Cacheable
      include Model::HasName
      include Model::HasDescription
      include Model::HasLicense

      contextify :ronin_scanner

      # The primary-key of the scanner
      property :id, Serial

      #
      # Creates a new {Scanner} object.
      #
      # @param [Hash] options
      #   Additional options for the scanner.
      #
      # @since 0.2.0
      #
      def initialize(options={})
        super(options)

        initialize_params(options)
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
      # @since 0.2.0
      #
      def each
        return enum_for(:each) unless block_given?

        scan do |result|
          result = normalize_result(result)

          if result
            yield result
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
      # @yieldparam [DataMapper::Resource]
      #   A new or pre-existing resource.
      #
      # @return [Scanner, Enumerator]
      #   If no block was given, an `Enumerator` object will be returned.
      #
      # @since 0.2.0
      #
      def each_resource
        return enum_for(:import) unless block_given?

        scan do |result|
          result = normalize_result(result)

          if result
            resource = new_resource(result)

            if resource
              yield resource
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
      # @yieldparam [DataMapper::Resource]
      #   A resource that exists in the Database.
      #
      # @return [Scanner, Enumerator]
      #   If no block was given, an `Enumerator` object will be returned.
      #
      # @since 0.2.0
      #
      def import_each
        return enum_for(:import_each) unless block_given?

        each_resource do |result|
          yield resource if resource.save
        end
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
      # @since 0.2.0
      #
      def normalize_result(result)
        result
      end

      #
      # Creates a new Database resource.
      #
      # @param [result]
      #   A result from the scan.
      #
      # @return [DataMapper::Resource, nil]
      #   The resource created from the result, or `nil` if a resource
      #   could not be created from the result.
      #
      # @since 0.2.0
      #
      def new_resource(result)
        nil
      end

      #
      # The default method which will actually perform the scanning.
      #
      # @since 0.2.0
      #
      def scan(&block)
      end

    end
  end
end
