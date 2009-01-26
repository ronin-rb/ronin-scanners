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
    #
    # == Nikto options:
    #
    class NiktoTask < RProgram::Task

      short_option :flag => '-h', :name => :host
      short_option :flag => '-config', :name => :config
      short_option :flag => '-Cgidirs', :name => :cgi_dirs
      short_option :flag => '-cookies', :name => :print_cookies
      short_option :flag => '-evasion', :name => :evasion
      short_option :flag => '-findonly', :name => :only_find
      short_option :flag => '-Format', :name => :format

      def html_format!
        self.format = 'HTM'
      end

      def text_format!
        self.format = 'TXT'
      end

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
