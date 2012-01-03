#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'net/telnet'

module Ronin
  module Bruteforcers
    #
    # {Telnet} attempts to login to an Telnet Service, using wordlists of
    # user-names and passwords.
    #
    class Telnet < ServiceBruteforcer

      # The port Telnet is listening on
      parameter :port, :default => 23,
                       :description => 'The port that Telnet is listening on'

      protected

      #
      # Opens a Telnet session.
      #
      # @return [Net::Telnet]
      #   The new Net::Telnet session.
      #
      def open_session
        Net::Telnet.new('Host' => self.host, 'Port' => self.port)
      end

      #
      # Closes a Telnet session.
      #
      # @param [Net::Telnet] telnet
      #   A Net::Telnet session.
      #
      def close_session(telnet)
        telnet.close
      end

      #
      # Attemps to authenticate with the Telnet credentials.
      #
      # @param [Net::Telnet] telnet
      #   The Net::Telnet session.
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
      def authenticate(telnet,username,password)
        begin
          telnet.login(username,password)
        rescue Timeout::Error
          return false
        end

        return true
      end

    end
  end
end
