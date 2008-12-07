#
#--
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008 Hal Brodigan (postmodern.mod3 at gmail.com)
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
#++
#

require 'rprogram/task'

module Ronin
  module Scanners
    class NmapTask < RProgram::Task

      # TARGET SPECIFICATIONS:
      short_option '-iL', :name => :target_file
      short_option '-iR', :name => :random_targets
      long_option '--exclude', :name => :exclude, :separator => ','
      long_option '--excludefile', :name => :exclude_file

      # HOST DISCOVERY:
      short_option '-sL', :name => :list
      short_option '-sP', :name => :ping
      short_option '-PN', :name => :skip_discovery
      short_option '-PS', :name => :syn_discovery
      short_option '-PA', :name => :ack_discovery
      short_option '-PU', :name => :udp_discovery
      short_option '-PE', :name => :icmp_echo_discovery
      short_option '-PP', :name => :icmp_timestamp_discovery
      short_option '-PM', :name => :icmp_netmask_discovery
      short_option '-PO', :name => :ip_ping
      short_option '-n', :name => :disable_dns
      short_option '-R', :name => :enable_dns
      long_option '--dns-servers', :separator => ','
      long_option '--system-dns'

      # SCAN TECHNIQUES:
      short_option '-sS', :name => :syn_scan
      short_option '-sT', :name => :connect_scan
      short_option '-sA', :name => :ack_scan
      short_option '-sW', :name => :window_scan
      short_option '-sM', :name => :maimon_scan
      short_option '-sU', :name => :udp_scan
      short_option '-sN', :name => :null_scan
      short_option '-sF', :name => :fin_scan
      short_option '-sX', :name => :xmas_scan
      long_option '--scanflags', :name => :tcp_scan_flags
      short_option '-sI', :name => :idle_scan
      short_option '-s0', :name => :ip_scan
      short_option '-b', :name => :ftp_bounce_scan
      long_option '--traceroute', :name => :traceroute
      long_option '--reason', :name => :show_reason

      # PORT SPECIFICATION AND SCAN ORDER:
      short_option '-p', :name => :ports
      short_option '-F', :name => :fast
      short_option '-r', :name => :consecutively
      long_option '--top-ports'
      long_option '--port-ratio'

      # SERVICE/VERSION DETECTION:
      short_option '-sV', :name => :service_scan
      long_option '--version-intensity'
      long_option '--version-light'
      long_option '--version-all'
      long_option '--version-trace'

      # SCRIPT SCAN:
      short_option '-sC', :name => :default_script
      long_option '--script'
      long_option '--script-args', :name => :script_params, :separator => ','
      long_option '--script-trace'
      long_option '--script-updatedb', :name => :update_scriptdb

      # OS DETECTION:
      short_option '-O', :name => :os_fingerprint
      long_option '--osscan_limit', :name => :limit_os_scan
      long_option '--osscan_guess', :name => :max_os_scan

      # TIMING AND PERFORMANCE:
      long_option '--min-hostgroup', :name => :min_host_group
      long_option '--max-hostgroup', :name => :max_host_group
      long_option '--min-parallelism'
      long_option '--max-parallelism'
      long_option '--min-rtt-timeout'
      long_option '--max-rtt-timeout'
      long_option '--max-retries'
      long_option '--host-timeout'
      long_option '--scan-delay'
      long_option '--max-scan-delay'
      long_option '--min-rate'
      long_option '--max-rate'

      # FIREWALL/IDS EVASION AND SPOOFING:
      short_option '-f', :name => :packet_fragments
      long_option '--mtu'
      short_option '-D', :name => :decoys
      short_option '-S', :name => :spoof
      short_option '-e', :name => :interface
      short_option '-g', :name => :source_port
      long_option '--data-length'
      long_option '--ip-options'
      long_option '--ttl'
      long_option '--spoof-mac'
      long_option '--badsum', :name => :bad_checksum

      # OUTPUT:
      short_option '-oN', :name => :save
      short_option '-oX', :name => :xml
      short_option '-oS', :name => :skiddie
      short_option '-oG', :name => :grepable
      short_option '-v', :name => :verbose
      long_option '--open', :name => :show_open_ports
      long_option '--packet-trace', :name => :show_packets
      long_option '--iflist', :name => :show_interfaces
      long_option '--log-errors', :name => :show_log_errors
      long_option '--append-output', :name => :append
      long_option '--resume'
      long_option '--stylesheet'
      long_option '--webxml', :name => :nmap_stylesheet
      long_option '--no-stylesheet', :name => :disable_stylesheet

      # MISC:
      short_option '-6', :name => :ipv6
      short_option '-A', :name => :all
      long_option '--datadir', :name => :nmap_datadir
      long_option '--send-eth', :name => :raw_ethernet
      long_option '--send-ip', :name => :raw_ip
      long_option '--privledged'
      long_option '--unprivleged'
      short_option '-V', :name => :version
      short_option '-h', :name => :help

    end
  end
end
