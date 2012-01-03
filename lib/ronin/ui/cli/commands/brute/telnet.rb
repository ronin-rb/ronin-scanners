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

require 'ronin/ui/cli/bruteforcer_command'
require 'ronin/bruteforcers/telnet'

module Ronin
  module UI
    module CLI
      module Commands
        module Brute
          class Telnet < BruteforcerCommand

            summary 'Performs Telnet bruteforcing against a host'

            #
            # Runs the {Ronin::Bruteforcers::Telnet} scanner.
            #
            def execute
              print_info 'Saving captured Telnet credentials ...' if import?

              brute

              print_info 'All valid Telnet credentials saved.' if import?
            end

          end
        end
      end
    end
  end
end
