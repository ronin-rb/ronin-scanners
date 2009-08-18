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

require 'rprogram/task'

module Ronin
  module Scanners
    #
    # == Nikto options:
    # <tt>-h</tt>:: <tt>nikto.host</tt>
    # <tt>-config</tt>:: <tt>nikto.config</tt>
    # <tt>-Cgidirs</tt>:: <tt>nikto.cgi_dirs</tt>
    # <tt>-cookies</tt>:: <tt>nikto.print_cookies</tt>
    # <tt>-evasion</tt>:: <tt>nikto.evasion</tt>
    # <tt>-findonly</tt>:: <tt>nikto.evasion</tt>
    # <tt>-Format</tt>:: <tt>nikto.format</tt>
    # <tt>-generic</tt>:: <tt>nikto.full_scan</tt>
    # <tt>-id</tt>:: <tt>nikto.http_auth</tt>
    # <tt>-mutate</tt>:: <tt>nikto.mutate_checks</tt>
    # <tt>-nolookup</tt>:: <tt>nikto.no_lookup</tt>
    # <tt>-output</tt>:: <tt>nikto.output</tt>
    # <tt>-port</tt>:: <tt>nikto.port</tt>
    # <tt>-root</tt>:: <tt>nikto.root</tt>
    # <tt>-ssl</tt>:: <tt>nikto.ssl</tt>
    # <tt>-timeout</tt>:: <tt>nikto.timeout</tt>
    # <tt>-useproxy</tt>:: <tt>nikto.enable_proxy</tt>
    # <tt>-vhost</tt>:: <tt>nikto.vhost</tt>
    # <tt>-Version</tt>:: <tt>nikto.version</tt>
    # <tt>-404</tt>:: <tt>nikto.not_found_message</tt>
    # <tt>-dbcheck</tt>:: <tt>nikto.validate_checks</tt>
    # <tt>-debug</tt>:: <tt>nikto.debug</tt>
    # <tt>-update</tt>:: <tt>nikto.update</tt>
    # <tt>-verbose</tt>:: <tt>nikto.verbose</tt>
    #
    class NiktoTask < RProgram::Task

      short_option :flag => '-h', :name => :host
      short_option :flag => '-config', :name => :config
      short_option :flag => '-Cgidirs', :name => :cgi_dirs
      short_option :flag => '-cookies', :name => :print_cookies
      short_option :flag => '-evasion', :name => :evasion

      #
      # Enable random URI encoding.
      #
      def random_uri_encoding!
        self.evasion ||= ''
        self.evasion << '1'
      end

      #
      # Enable adding self-referencing directories (<tt>/./</tt>) to the
      # request.
      #
      def directory_self_reference!
        self.evasion ||= ''
        self.evasion << '2'
      end

      #
      # Enable premature URL ending.
      #
      def premature_url_ending!
        self.evasion ||= ''
        self.evasion << '3'
      end

      #
      # Enable prepend long random strings to the request.
      #
      def prepend_random_strings!
        self.evasion ||= ''
        self.evasion << '4'
      end

      #
      # Enable fake parameters to files.
      #
      def fake_params_to_files!
        self.evasion ||= ''
        self.evasion << '5'
      end

      #
      # Enable using a tab character as the request spacer, instead of
      # spaces.
      #
      def tab_request_spacer!
        self.evasion ||= ''
        self.evasion << '6'
      end

      #
      # Enable random case sensitivity.
      #
      def random_casing!
        self.evasion ||= ''
        self.evasion << '7'
      end

      #
      # Enable use of Windows style directory separators
      # (<tt>\\</tt> instead of <tt>/</tt>).
      #
      def windows_directories!
        self.evasion ||= ''
        self.evasion << '8'
      end

      #
      # Enable session splicing.
      #
      def session_splicing!
        self.evasion ||= ''
        self.evasion << '9'
      end

      short_option :flag => '-findonly', :name => :only_find
      short_option :flag => '-Format', :name => :format

      #
      # Sets the report format to +HTM+.
      #
      def html_format!
        self.format = 'HTM'
      end

      #
      # Sets the report format to +TXT+.
      #
      def text_format!
        self.format = 'TXT'
      end

      #
      # Sets the report format to +CVS+.
      #
      def csv_format!
        self.format = 'CSV'
      end

      short_option :flag => '-generic', :name => :full_scan
      short_option :flag => '-id', :name => :http_auth
      short_option :flag => '-mutate', :name => :mutate_checks
      short_option :flag => '-nolookup', :name => :no_lookup
      short_option :flag => '-output', :name => :output
      short_option :flag => '-port', :name => :port
      short_option :flag => '-root', :name => :root
      short_option :flag => '-ssl', :name => :ssl
      short_option :flag => '-timeout', :name => :timeout
      short_option :flag => '-useproxy', :name => :enable_proxy
      short_option :flag => '-vhost', :name => :vhost
      short_option :flag => '-Version', :name => :version

      short_option :flag => '-404', :name => :not_found_message
      short_option :flag => '-dbcheck', :name => :validate_checks
      short_option :flag => '-debug', :name => :debug
      short_option :flag => '-update', :name => :update
      short_option :flag => '-verbose', :name => :verbose

    end
  end
end
