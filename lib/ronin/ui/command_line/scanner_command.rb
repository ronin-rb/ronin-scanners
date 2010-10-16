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

require 'ronin/ui/command_line/command'

module Ronin
  module UI
    module CommandLine
      class ScannerCommand < Command

        class_option :first, :type => :numeric, :aliases => '-n'
        class_option :save, :default => false, :aliases => '-S'

        protected

        #
        # Performs a scan using the `@scanner` instance variable.
        #
        def scan!
          enum = if options.save?
                   @scanner.import_each
                 else
                   @scanner.each
                 end

          enum.each_with_index do |result,index|
            puts result

            break if (options[:first] && index+1 == options[:first])
          end
        end

      end
    end
  end
end
