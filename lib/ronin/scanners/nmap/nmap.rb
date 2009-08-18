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

require 'ronin/scanners/nmap/nmap_task'

require 'rprogram/program'
require 'scandb'
require 'tempfile'

module Ronin
  module Scanners
    class Nmap < RProgram::Program

      name_program 'nmap'

      #
      # Perform an Nmap scan using the given _options_ and _block_.
      # If a _block_ is given, it will be passed a newly created
      # NmapTask object.
      #
      def self.scan(options={},&block)
        self.find.scan(options,&block)
      end

      #
      # Perform an Nmap scan using the given _options_ and _block_.
      # If a _block_ is given, it will be passed a newly created
      # NmapTask object.
      #
      def scan(options={},&block)
        run_task(NmapTask.new(options,&block))
      end

      #
      # Perform an Nmap scan using the given _options_ and save
      # the resulting scan information into ScanDB. If a _block_ is given,
      # it will be passed each ScanDB::Host object from the scan.
      #
      def import_scan(options={},&block)
        file = Tempfile.new('nmap',Config::TMP_DIR)

        # perform the scan
        scan(options.merge(:xml => file))

        # import the xml file into ScanDB
        hosts = ScanDB::Nmap.import_xml(file,&block)

        file.delete
        return hosts
      end

    end
  end
end
