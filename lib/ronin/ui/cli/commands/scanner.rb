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

require 'ronin/ui/cli/script_command'
require 'ronin/scanners/scanner'

module Ronin
  module UI
    module CLI
      module Commands
        class Scanner < ScriptCommand

          summary 'Loads and runs a scanner'

          script_class Ronin::Scanners::Scanner

          # scanner options
          option :first, :type => Integer, :flag => '-N'
          option :import, :type => true, :flag => '-I'

          def execute
            if console?
              UI::Console.start(script)
            else
              limit = (first || Float::INFINITY)
              enum  = if import? then script.import
                      else            script.each
                      end

              print_info "Scanning ..."

              count = 0

              enum.each_with_index do |result|
                puts result

                count += 1
                break if count >= limit
              end

              print_info "Scan complete."
            end
          end

        end
      end
    end
  end
end
