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

require 'net/smtp'

module Ronin
  module Bruteforcers
    #
    # {SMTP} attempts to login to an SMTP Service, using wordlists of
    # user-names and passwords.
    #
    class SMTP < ServiceBruteforcer

      # The port SMTP is listening on
      parameter :port, :default => 25,
                       :description => 'The port that SMTP is listening on'

      # Enables SSL for the SMTP connections
      parameter :ssl, :default     => false,
                      :description => 'Specifies whether to enable SSL'

      # The HELO String to send to the SMTP Service
      parameter :helo, :type        => String,
                       :default     => 'localhost',
                       :description => 'HELO String to send'

      protected

      #
      # Opens a SMTP session.
      #
      # @yield [smtp]
      #   The given block will be passed the SMTP session.
      #   After the block has returned, the SMTP session will be closed.
      #
      # @yieldparam [Net::SMTP] smtp
      #   The Net::SMTP session.
      #
      def session(&block)
        smtp = Net::SMTP.new(self.host,self.port)
        smtp.enable_ssl if self.ssl

        begin
          smtp.start(self.helo)
        rescue => e
          print_error "#{e.class}: #{e.message}"

          sleep 4
          retry
        end

        yield smtp

        smtp.finish
      end

      #
      # Attemps to authenticate with the SMTP credentials.
      #
      # @param [Net::SMTP] smtp
      #   The Net::SMTP session.
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
      def authenticate(smtp,username,password)
        begin
          smtp.authenticate(username,password)
        rescue Net::SMTPAuthenticationError 
          return false
        end

        return true
      end

    end
  end
end
