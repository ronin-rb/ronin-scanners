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

require 'ronin/config'

require 'rprogram/program'

module Ronin
  class SQLMap < RProgram::Program

    # The directories to search within for `sqlmap.py`.
    DIRS = ['sqlmap', 'sqlmap-dev']

    name_program 'sqlmap.py'
    alias_program 'sqlmap'

    #
    # Finds the `sqlmap.py` utility in either the users home directory or
    # installed on the system.
    #
    # @return [SQLMap]
    #   The SQLMap program.
    #
    # @raise [RProgram::ProgramNotFound]
    #   The `sqlmap.py` utility could not be found.
    #
    def self.find
      DIRS.each do |dir|
        path = File.join(Config::HOME,dir)

        if File.directory?(path)
          return self.new(File.join(path,self.program_name))
        end
      end

      super()
    end

  end
end
