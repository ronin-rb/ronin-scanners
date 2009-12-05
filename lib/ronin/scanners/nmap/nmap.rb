#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2009 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'nmap/task'
require 'nmap/program'
require 'tempfile'

module Ronin
  module Scanners
    class Nmap

      include Enumerable

      #
      # Creates a new Nmap scanner object.
      #
      # @yield [nmap]
      #   If a block is given, it will be passed the newly created Nmap
      #   object.
      #
      # @yieldparam [Nmap] nmap
      #   The new Nmap object.
      #
      def initialize(&block)
        @program = ::Nmap::Program.find
        @options = ::Nmap::Task.new()

        block.call(self) if block
      end

      #
      # The options that will be ran with nmap.
      #
      # @yield [task]
      #   If a block is given, it will be passed the nmap options.
      #
      # @yieldparam [Nmap::Task] task
      #   The nmap options.
      #
      # @return [Nmap::Task]
      #   The nmap options.
      #
      # @see http://ruby-nmap.rubyforge.org/Nmap/Task.html
      #
      def options(&block)
        block.call(@options) if block

        return @options
      end

      #
      # Runs nmap.
      #
      # @return [true]
      #   The nmap scan was successful.
      #
      def run
        @xml = nil

        # make sure we have an XML output file
        @options.xml ||= Tempfile.new('ronin_scanners_nmap').path

        @program.run_task(@options)
        return true
      end

      #
      # The XML output of a previous nmap scan.
      #
      # @return [Nmap::XML]
      #   The Nmap XML parser.
      #
      # @see http://ruby-nmap.rubyforge.org/Nmap/XML.html
      #
      def xml
        @xml ||= ::Nmap::XML.new(@options.xml)
      end

      #
      # Itereates over every host from a previous nmap scan.
      #
      # @yield [host]
      #   The given block will receive every host from the scan.
      #
      # @yieldparam [Nmap::Host] host
      #   A host from the previous nmap scan.
      #
      # @see http://ruby-nmap.rubyforge.org/Nmap/Host.html
      #
      def each(&block)
        xml.each_host(&block)
      end

    end
  end
end
