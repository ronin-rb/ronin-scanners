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

require 'ronin/ui/command_line/scanner_command'
require 'ronin/scanners/nmap'

module Ronin
  module UI
    module CommandLine
      module Commands
        class Nmap < ScannerCommand
          # The hosts or ranges to exclude from the scan.
          class_option :exclude, :description => 'The hosts to exclude'

          # The ports or port ranges which will be scanned.
          class_option :ports, :type => :string, :aliases => '-p'

          # Specifies that a Ping Scan will be performed.
          class_option :ping_scan, :default => false, :aliases => '-sP'

          # Specifies that a Connect Scan will be performed.
          class_option :connect_scan, :default => true, :aliases => '-sT'

          # Specifies that a TCP SYN scan will be performed.
          class_option :syn_scan, :default => false, :aliases => '-sS'

          # Specifies that a TCP ACK scan will be performed.
          class_option :ack_scan, :default => false, :aliases => '-sA'

          # Specifies that a TCP NULL scan will be performed.
          class_option :null_scan, :default => false, :aliases => '-sN'

          # Specifies that a TCP FIN scan will be performed.
          class_option :fin_scan, :default => false, :aliases => '-sF'

          # Specifies that a TCP XMAS scan will be performed.
          class_option :xmas_scan, :default => false, :aliases => '-sX'

          # Specifies that a UDP scan will be performed.
          class_option :udp_scan, :default => false, :aliases => '-sU'

          # Specifies that a Service scan will be performed.
          class_option :service_scan, :default => true, :aliases => '-sV'

          # Specifies that an Idle Scan will be performed.
          class_option :idle_scan, :default => false, :aliases => '-sI'

          # Specifies that a Window Scan will be performed.
          class_option :window_scan, :default => false, :aliases => '-sW'

          # Specifies whether to enable verbose output
          class_option :verbose, :default => false, :aliases => '-v'

          # The input file to read hosts/ports from
          class_option :import, :type => :string, :aliases => '-i'

          # The output file to write hosts/ports to
          class_option :output, :type => :string, :aliases => '-o -oX'

          # The hosts which will be scanned.
          argument :hosts, :required => true

          #
          # Runs the nmap scanner.
          #
          def execute
            Database.setup

            @scanner = Scanners::Nmap.new
            @scanner.hosts = hosts
            @scanner.params = options

            scan!
          end

        end
      end
    end
  end
end
