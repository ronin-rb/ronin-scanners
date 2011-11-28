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

require 'ronin/ui/cli/script_command'
require 'ronin/bruteforcers/bruteforcer'

module Ronin
  module UI
    module CLI
      module Commands
        class Bruteforcer < ScriptCommand

          desc 'Loads and runs a bruteforcer'

          script_class Ronin::Bruteforcers::Bruteforcer

          # scanner options
          class_option :first, :type => :boolean, :aliases => '-N'
          class_option :import, :type => :boolean, :aliases => '-I'

          #
          # Loads and runs the scanner.
          #
          def execute
            unless (@bruteforcer = load_script)
              print_error "Could not find the specified bruteforcer"
              exit -1
            end

            @bruteforcer.params = options[:params]
            @bruteforcer.run(options)
          end

        end
      end
    end
  end
end
