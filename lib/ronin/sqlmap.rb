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

require 'ronin/sqlmap_task'
require 'ronin/config'

require 'rprogram/program'

module Ronin
  #
  # Represents a Ruby-ful interface to the `sqlmap` utility.
  #
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
    # @since 1.0.0
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

    #
    # Finds and invokes the `sqlmap` utility.
    #
    # @param [Hash{Symbol => Object}] options
    #   Options for `sqlmap`.
    #
    # @yield [sqlmap]
    #   The given block will be passed the sqlmap task to be configured.
    #
    # @yieldparam [SQLMapTask] sqlmap
    #   The sqlmap task to be configured.
    #
    # @return [Boolean]
    #   Specifies whether the `sqlmap` utility exited successfully.
    #
    # @see #scan
    #
    # @since 1.0.0
    #
    def self.scan(options={},&block)
      find.scan(options,&block)
    end

    #
    # Invokes the `sqlmap` utility.
    #
    # @param [Hash{Symbol => Object}] options
    #   Options for `sqlmap`.
    #
    # @yield [sqlmap]
    #   The given block will be passed the sqlmap task to be configured.
    #
    # @yieldparam [SQLMapTask] sqlmap
    #   The sqlmap task to be configured.
    #
    # @return [Boolean]
    #   Specifies whether the `sqlmap` utility exited successfully.
    #
    # @see SQLMap
    #
    # @since 1.0.0
    #
    def scan(options={},&block)
      run_task(SQLMapTask.new(options,&block))
    end

  end
end
