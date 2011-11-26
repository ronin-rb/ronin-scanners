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

require 'ronin/bruteforcers/bruteforcer'
require 'ronin/service_credential'

module Ronin
  module Bruteforcers
    class ServiceBruteforcer < Bruteforcer

      # The host that will be bruteforced
      parameter :host, :type        => String,
                       :description => 'Host that the Service is running on'

      # The port that will be bruteforced
      parameter :port, :type        => Integer,
                       :description => 'Port that the Service is running on'

      protected

      #
      # Creates a new Credential.
      #
      # @param [String] username
      #   The username for the credential.
      #
      # @param [String] password
      #   The password for the credential.
      #
      # @return [ServiceCredential]
      #   The new Credential associated with the Service.
      #
      # @api semipublic
      #
      def new_credential(username,password)
        ServiceCredential.first_or_new(
          :user_name => UserName.parse(username),
          :password  => Password.parse(password),

          :open_port => OpenPort.first_or_new(
            :ip_address => IPAddress.lookup(self.host).first,
            :port       => Port.from(self.port)
          )
        )
      end

    end
  end
end
