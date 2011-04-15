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

require 'resolv'
require 'net/ssh'

module Ronin
  module Scanners
    #
    # {SSH} attempts to login to an SSH Service, using wordlists of
    # user-names and passwords.
    #
    class SSH < CredentialScanner

      # The host that will be scanned
      parameter :host, :type => String,
                       :description => 'The host to scan'

      # The port SSH is listening on
      parameter :port, :default => 22,
                       :description => 'The port that SSH is listening on'

      # The path to the SSH user-names wordlist
      parameter :user_list, :type => String,
                            :description => 'The user-list'

      # The path to the SSH passwords wordlist
      parameter :password_list, :type => String,
                                :description => 'The password-list'

      #
      # Creates new Service Credentials from the SSH Scanner results.
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
      # @since 1.0.0
      #
      def each_resource(&block)
        @open_port = OpenPort.first_or_new(
          :ip_address => IPAddress.first_or_new(
            :address => Resolv.getaddress(self.host)
          ),

          :port => Port.first_or_new(
            :number => self.port
          )
        )

        return super(&block)
      end

      protected

      #
      # Performs the SSH scan.
      #
      # @yield [credential]
      #   The given block will be passed each valid credential.
      #
      # @yieldparam [Hash{Symbol => String}] credential
      #   A valid credential is a Hash containing `:user` and `:password`
      #   keys.
      #
      # @since 1.0.0
      #
      def scan
        options = {
          :port => self.port,
          :auth_methods => ['password']
        }

        File.open(self.user_list) do |users|
          users.each_line do |user|
            user.chomp!

            File.open(self.password_list) do |passwords|
              passwords.each_line do |password|
                password.chomp!

                options[:password] = password

                begin
                  Net::SSH.start(self.host, user, options) do |ssh|
                    yield(:user => user, :password => password)
                  end
                rescue SystemCallError,
                       Net::SSH::AuthenticationFailed
                end
              end
            end
          end
        end
      end

      #
      # Creates a new Service Credential from the SSH Scanner result.
      #
      # @param [Hash{Symbol => String}] result
      #   A SSH Scanner result.
      #
      # @return [ServiceCredential]
      #   The new Service Credential.
      #
      # @since 1.0.0
      #
      def new_resource(result)
        ServiceCredential.first_or_new(
          :user_name => UserName.first_or_new(
            :name => result[:user]
          ),

          :password => Password.first_or_new(
            :clear_text => result[:password]
          ),

          :open_port => @open_port
        )
      end
    end
  end
end
