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

require 'data_objects'

module Ronin
  module Bruteforcers
    class DB < ServiceBruteforcer

      parameter :type, :type        => String,
                       :description => 'The type of database'

      parameter :db, :type        => String,
                     :default     => 'information_schema',
                     :description => 'The database to try loggin into'

      protected

      def open_session
        require "do_#{self.type}"

        return Addressable::URI.new(
          :scheme => self.type,
          :host   => self.host,
          :port   => self.port,
          :path   => self.db
        )
      end

      def authenticate(uri,username,password)
        uri.user     = username
        uri.password = password

        begin
          DataObjects::Connection.new(uri)
        rescue DataObjects::Error
          return false
        end

        return true
      end

    end
  end
end
