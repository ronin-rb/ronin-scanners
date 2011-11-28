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

require 'ronin/bruteforcers/service_bruteforcer'

require 'net/ssh'

module Ronin
  module Bruteforcers
    #
    # {SSH} attempts to login to an SSH Service, using wordlists of
    # user-names and passwords.
    #
    class SSH < ServiceBruteforcer

      # The port SSH is listening on
      parameter :port, :default => 22,
                       :description => 'The port that SSH is listening on'

      protected

      #
      # Passes options for the SSH session.
      #
      # @return [Hash]
      #   The option Hash for Net::SSH.
      #
      def open_session
        {:port => self.port, :auth_methods => ['password']}
      end

      #
      # Attemps to authenticate with the SSH credentials.
      #
      # @param [Hash] options
      #   Additional options for Net::SSH.
      #
      # @param [String] username
      #   The username to authenticate with.
      #
      # @param [String] password
      #   The password to authenticate with.
      #
      # @return [Boolean]
      #   Specifies whether the credentials were valid.
      #
      def authenticate(options,username,password)
        options[:password] = password

        begin
          Net::SSH.start(self.host,username,options) do |ssh|
          end
        rescue SystemCallError, Net::SSH::AuthenticationFailed
          return false
        end

        return true
      end

    end
  end
end
