#
#--
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
#++
#

require 'rprogram/task'

module Ronin
  module Scanners
    class NmapTask < RProgram::Task

      # TARGET SPECIFICATIONS:
      short_option :flag => '-iL', :name => :target_file
      short_option :flag => '-iR', :name => :random_targets
      long_option :flag => '--exclude', :name => :exclude, :separator => ','
      long_option :flag => '--excludefile', :name => :exclude_file

      # HOST DISCOVERY:
      short_option :flag => '-sL', :name => :list
      short_option :flag => '-sP', :name => :ping
      short_option :flag => '-PN', :name => :skip_discovery
      short_option :flag => '-PS', :name => :syn_discovery
      short_option :flag => '-PA', :name => :ack_discovery
      short_option :flag => '-PU', :name => :udp_discovery
      short_option :flag => '-PE', :name => :icmp_echo_discovery
      short_option :flag => '-PP', :name => :icmp_timestamp_discovery
      short_option :flag => '-PM', :name => :icmp_netmask_discovery
      short_option :flag => '-PO', :name => :ip_ping
      short_option :flag => '-n', :name => :disable_dns
      short_option :flag => '-R', :name => :enable_dns
      long_option :flag => '--dns-servers', :separator => ','
      long_option :flag => '--system-dns'

      # SCAN TECHNIQUES:
      short_option :flag => '-sS', :name => :syn_scan
      short_option :flag => '-sT', :name => :connect_scan
      short_option :flag => '-sA', :name => :ack_scan
      short_option :flag => '-sW', :name => :window_scan
      short_option :flag => '-sM', :name => :maimon_scan
      short_option :flag => '-sU', :name => :udp_scan
      short_option :flag => '-sN', :name => :null_scan
      short_option :flag => '-sF', :name => :fin_scan
      short_option :flag => '-sX', :name => :xmas_scan
      long_option :flag => '--scanflags', :name => :tcp_scan_flags
      short_option :flag => '-sI', :name => :idle_scan
      short_option :flag => '-s0', :name => :ip_scan
      short_option :flag => '-b', :name => :ftp_bounce_scan
      long_option :flag => '--traceroute', :name => :traceroute
      long_option :flag => '--reason', :name => :show_reason

      # PORT SPECIFICATION AND SCAN ORDER:
      short_option :flag => '-p', :name => :ports
      short_option :flag => '-F', :name => :fast
      short_option :flag => '-r', :name => :consecutively
      long_option :flag => '--top-ports'
      long_option :flag => '--port-ratio'

      # SERVICE/VERSION DETECTION:
      short_option :flag => '-sV', :name => :service_scan
      long_option :flag => '--version-intensity'
      long_option :flag => '--version-light'
      long_option :flag => '--version-all'
      long_option :flag => '--version-trace'

      # SCRIPT SCAN:
      short_option :flag => '-sC', :name => :default_script
      long_option :flag => '--script'
      long_option :flag => '--script-args',
                  :name => :script_params,
                  :separator => ','
      long_option :flag => '--script-trace'
      long_option :flag => '--script-updatedb', :name => :update_scriptdb

      # OS DETECTION:
      short_option :flag => '-O', :name => :os_fingerprint
      long_option :flag => '--osscan_limit', :name => :limit_os_scan
      long_option :flag => '--osscan_guess', :name => :max_os_scan

      # TIMING AND PERFORMANCE:
      long_option :flag => '--min-hostgroup', :name => :min_host_group
      long_option :flag => '--max-hostgroup', :name => :max_host_group
      long_option :flag => '--min-parallelism'
      long_option :flag => '--max-parallelism'
      long_option :flag => '--min-rtt-timeout'
      long_option :flag => '--max-rtt-timeout'
      long_option :flag => '--max-retries'
      long_option :flag => '--host-timeout'
      long_option :flag => '--scan-delay'
      long_option :flag => '--max-scan-delay'
      long_option :flag => '--min-rate'
      long_option :flag => '--max-rate'

      # FIREWALL/IDS EVASION AND SPOOFING:
      short_option :flag => '-f', :name => :packet_fragments
      long_option :flag => '--mtu'
      short_option :flag => '-D', :name => :decoys
      short_option :flag => '-S', :name => :spoof
      short_option :flag => '-e', :name => :interface
      short_option :flag => '-g', :name => :source_port
      long_option :flag => '--data-length'
      long_option :flag => '--ip-options'
      long_option :flag => '--ttl'
      long_option :flag => '--spoof-mac'
      long_option :flag => '--badsum', :name => :bad_checksum

      # OUTPUT:
      short_option :flag => '-oN', :name => :save
      short_option :flag => '-oX', :name => :xml
      short_option :flag => '-oS', :name => :skiddie
      short_option :flag => '-oG', :name => :grepable
      short_option :flag => '-v', :name => :verbose
      long_option :flag => '--open', :name => :show_open_ports
      long_option :flag => '--packet-trace', :name => :show_packets
      long_option :flag => '--iflist', :name => :show_interfaces
      long_option :flag => '--log-errors', :name => :show_log_errors
      long_option :flag => '--append-output', :name => :append
      long_option :flag => '--resume'
      long_option :flag => '--stylesheet'
      long_option :flag => '--webxml', :name => :nmap_stylesheet
      long_option :flag => '--no-stylesheet', :name => :disable_stylesheet

      # MISC:
      short_option :flag => '-6', :name => :ipv6
      short_option :flag => '-A', :name => :all
      long_option :flag => '--datadir', :name => :nmap_datadir
      long_option :flag => '--send-eth', :name => :raw_ethernet
      long_option :flag => '--send-ip', :name => :raw_ip
      long_option :flag => '--privledged'
      long_option :flag => '--unprivleged'
      short_option :flag => '-V', :name => :version
      short_option :flag => '-h', :name => :help

    end
  end
end
