#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/scanners/scanner'
require 'ronin/credential'

module Ronin
  module Scanners
    #
    # The {CredentialScanner} class represents scanners that yield
    # `Credential` results and resources.
    #
    class CredentialScanner < Scanner

      #
      # Creates a new credential scanner object.
      #
      # @yield []
      #   The given block will be used to create a new credential scanner
      #   object.
      #
      # @return [CredentialScanner]
      #   The new credential scanner object.
      #
      # @example
      #   ronin_credential_scanner do
      #     cache do
      #       self.name = 'some credential scanner'
      #       self.description = %{
      #         This is an example credential scanner.
      #       }
      #     end
      #
      #     protected
      #
      #     def scan
      #     end
      #   end
      #
      # @since 0.2.0
      #
      contextify :credential_scanner

    end
  end
end
