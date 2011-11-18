#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2011 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/scanners/service_credential_scanner'

require 'net/ssh'

module Ronin
  module Scanners
    #
    # {SSH} attempts to login to an SSH Service, using wordlists of
    # user-names and passwords.
    #
    class SSH < ServiceCredentialScanner

      # The host that will be scanned
      parameter :host, :type => String,
                       :description => 'The host to scan'

      # The port SSH is listening on
      parameter :port, :default => 22,
                       :description => 'The port that SSH is listening on'

      protected

      #
      # Performs the SSH scan.
      #
      # @yield [credential]
      #   The given block will be passed each valid credential.
      #
      # @yieldparam [Hash{Symbol => String}] credential
      #   A valid credential is a Hash containing `:username` and `:password`
      #   keys.
      #
      # @since 1.0.0
      #
      def scan
        options = {:port => self.port, :auth_methods => ['password']}

        each_credential do |username,password|
          options[:password] = password

          begin
            Net::SSH.start(self.host, username, options) do |ssh|
              yield(:username => username, :password => password)
            end
          rescue SystemCallError, Net::SSH::AuthenticationFailed
          end
        end
      end

    end
  end
end
