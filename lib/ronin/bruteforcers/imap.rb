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

require 'net/imap'

module Ronin
  module Bruteforcers
    #
    # {IMAP} attempts to login to an IMAP Service, using wordlists of
    # user-names and passwords.
    #
    class IMAP < ServiceBruteforcer

      # The port SMTP is listening on
      parameter :port, :default => 110,
                       :description => 'The port that IMAP is listening on'

      # Enables SSL for the IMAP connections
      parameter :ssl, :default     => false,
                      :description => 'Specifies whether to enable SSL'

      protected

      #
      # Opens a IMAP session.
      #
      # @return [Net::IMAP]
      #   The Net::IMAP session.
      #
      def open_session
        Net::IMAP.new(self.host, :port => self.port, :ssl => self.ssl)
      end

      #
      # Closes an IMAP session.
      #
      # @param [Net::IMAP] imap
      #   A Net::IMAP session.
      #
      def close_session(imap)
        imap.disconnect
      end

      #
      # Attemps to authenticate with the IMAP credentials.
      #
      # @param [Net::IMAP] imap
      #   The Net::IMAP session.
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
      def authenticate(imap,username,password)
        begin
          imap.login(username,password)
        rescue Net::IMAP::NoResponseError
          return false
        end

        return true
      end

    end
  end
end
