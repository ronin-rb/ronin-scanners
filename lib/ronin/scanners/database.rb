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

require 'ronin/scanner/service_credential_scanner'

require 'data_objects'

module Ronin
  module Scanners
    class Database < ServiceCredentialScanner

      parameter :type, :type        => Symbol,
                       :description => 'The type of database'

      parameter :host, :type        => String,
                       :description => 'The host to scan against'

      parameter :port, :type        => Integer,
                       :description => 'The port to scan against'

      parameter :database, :type        => String,
                           :description => 'The database to try loggin into'

      protected

      def scan
        uri = Addressable::URI.new(
          :schema => self.type,
          :host   => self.host,
          :port   => self.port,
          :path   => "/#{self.database}"
        )

        each_credential do |username,password|
          begin
            uri.user     = username
            uri.password = password

            DataObject::Connection.new(uri)

            yield(:username => username, :password => password)
          rescue DataObject::Error
          end
        end
      end

    end
  end
end
