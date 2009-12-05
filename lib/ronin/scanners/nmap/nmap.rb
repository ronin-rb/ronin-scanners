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

require 'ronin/scanners/scanner'

require 'nmap/task'
require 'nmap/program'
require 'nmap/xml'
require 'tempfile'

module Ronin
  module Scanners
    class Nmap

      include Enumerable
      include Scanner

      #
      # Creates a new Nmap scanner object.
      #
      # @param [Hash] options
      #   Nmap options.
      #
      # @option options [String] :path
      #   The specific path to the nmap utility.
      #
      # @yield [options]
      #   If a block is given, it will be passed the options that will be
      #   used with nmap.
      #
      # @yieldparam [Nmap::Task] options
      #   The options that will be used to run nmap.
      #
      # @example
      #   Nmap.new do |nmap|
      #     nmap.connect_scan = true
      #     nmap.ports = [80,8080,1080,4444]
      #   end
      #
      # @see http://ruby-nmap.rubyforge.org/Nmap/Task.html
      #
      def initialize(options={},&block)
        path = options.delete(:path)

        @program = if path
                     ::Nmap::Program.new(path)
                   else
                     ::Nmap::Program.find()
                   end

        @options = ::Nmap::Task.new(options)

        self.options(&block) if block
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
      # @yield [options]
      #   If a block is given, it will be passed the options used with
      #   nmap, before nmap is ran.
      #
      # @yieldparam [Nmap::Task] options
      #   The nmap options.
      #
      # @return [true]
      #   The nmap scan was successful.
      #
      # @example
      #   nmap.run do |nmap|
      #     nmap.connect_scan = true
      #     nmap.ports = [20,21,22,23,25,80]
      #   end
      #
      # @see http://ruby-nmap.rubyforge.org/Nmap/Task.html
      #
      def run(&block)
        @xml = nil

        options do |opts|
          block.call(opts) if block

          # make sure we have an XML output file
          opts.xml ||= Tempfile.new('ronin_scanners_nmap').path
        end

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
        if @options.xml
          @xml ||= ::Nmap::XML.new(@options.xml)
        end

        return @xml
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
      # @return [Nmap]
      #   The nmap scanner.
      #
      # @see http://ruby-nmap.rubyforge.org/Nmap/Host.html
      #
      def each(&block)
        if (parser = self.xml)
          parser.each_host(&block)
        end

        return self
      end

      protected

      #
      # Performs a nmap scan and passes the scanned hosts to scanner rules.
      #
      # @yield [host]
      #   Every host that nmap scanned, will be passed to the given block.
      #
      # @yieldparam [Nmap::Host] host
      #   A host from the nmap scan.
      #
      def each_target(&block)
        run()

        each(&block)
      end

    end
  end
end
