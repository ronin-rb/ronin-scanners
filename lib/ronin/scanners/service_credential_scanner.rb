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

require 'ronin/scanners/credential_scanner'
require 'ronin/service_credential'

module Ronin
  module Scanners
    class ServiceCredentialScanner < CredentialScanner

      #
      # Creates new Service Credentials from the Scanner results.
      #
      # @yield [credential]
      #   The given block will be passed each Service Credential.
      #
      # @yieldparam [ServiceCredential] credential
      #   A new or pre-existing Service Credential.
      #
      # @return [SSH, Enumerator]
      #   If no block was given, an `Enumerator` object will be returned.
      #
      def each_resource(&block)
        @open_port = OpenPort.first_or_new(
          :ip_address => IPAddress.lookup(self.host).first,
          :port       => Port.from(self.port)
        )

        return super(&block)
      end

      protected

      def new_resource(result)
        ServiceCredential.first_or_new(
          :user_name => UserName.parse(result[:username]),
          :password  => Password.parse(result[:password]),
          :open_port => @open_port
        )
      end

    end
  end
end
