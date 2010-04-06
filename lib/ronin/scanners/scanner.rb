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

require 'parameters'

module Ronin
  module Scanners
    class Scanner

      include Enumerable
      include Parameters

      #
      # Creates a new {Scanner} object.
      #
      # @param [Hash] options
      #   Additional options for the scanner.
      #
      # @since 0.2.0
      #
      def initialize(options={})
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
      def each(&block)
        return enum_for(:scan) unless block

        scan(&block)
        return self
      end

      protected

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
