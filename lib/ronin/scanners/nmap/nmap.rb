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

      def initialize(&block)
        @program = ::Nmap::Program.find
        @options = ::Nmap::Task.new()

        block.call(self) if block
      end

      def options(&block)
        block.call(@options) if block

        return @options
      end

      def xml
        unless @xml
          # make sure we have an XML output file
          @options.xml ||= Tempfile.new('ronin_scanners_nmap').path

          @program.run_task(@options)

          # parse scan results
          @xml = ::Nmap::XML.new(@options.xml)
        end

        return @xml
      end

      def each(&block)
        xml.each_host(&block)
      end

    end
  end
end
