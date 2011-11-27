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

require 'ronin/ui/cli/bruteforcer_command'
require 'ronin/bruteforcers/pop3'

module Ronin
  module UI
    module CLI
      module Commands
        module Brute
          class IMAP < BruteforcerCommand

            desc 'Performs IMAP bruteforcing against a host'

            # The port that IMAP is listening on
            param_option :port, :aliases => '-p'

            # Enables SSL for the IMAP connection(s)
            param_option :ssl, :aliases => '-S'

            # The host that is running IMAP
            argument :host, :required => true

            #
            # Runs the {Ronin::Bruteforcers::IMAP} scanner.
            #
            def execute
              print_info 'Saving captured IMAP credentials ...' if options.import?

              brute

              print_info 'All valid IMAP credentials saved.' if options.import?
            end

          end
        end
      end
    end
  end
end
