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

require 'net/pop'

module Ronin
  module Bruteforcers
    #
    # {POP3} attempts to login to an POP3 Service, using wordlists of
    # user-names and passwords.
    #
    class POP3 < ServiceBruteforcer

      # The port SMTP is listening on
      parameter :port, :default => 110,
                       :description => 'The port that POP3 is listening on'

      # Enables SSL for the POP3 connections
      parameter :ssl, :default     => false,
                      :description => 'Specifies whether to enable SSL'

      protected

      #
      # Opens a POP3 session.
      #
      # @return [Net::POP3]
      #   The new Net::POP3 session.
      #
      def open_session
        pop3 = Net::POP3.new(self.host,self.port)
        pop3.enable_ssl if self.ssl

        return pop3
      end

      #
      # Closes a POP3 session.
      #
      # @param [Net::POP3] pop3
      #   A Net::POP3 session.
      #
      def close_session(pop3)
        pop3.finish if pop3.started?
      end

      #
      # Attemps to authenticate with the POP3 credentials.
      #
      # @param [Net::POP3] pop3
      #   The Net::POP3 session.
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
      def authenticate(pop3,username,password)
        begin
          pop3.start(username,password)
        rescue Net::POPAuthenticationError
          return false
        end

        return true
      end

    end
  end
end
