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

require 'ronin/ui/cli/scanner_command'

module Ronin
  module UI
    module CLI
      class CredentialScannerCommand < ScannerCommand

        class_option :wordlists, :type    => :array,
                                 :aliases => '-w',
                                 :banner  => 'FILE [...]',
                                 :desc    => 'Wordlist file(s) to use'

        class_option :mutations, :type    => :hash,
                                 :aliases => '-m',
                                 :banner  => 'STRING:SUBSTITUTE',
                                 :desc    => 'Hash of mutations to perform'

        class_option :username, :type    => :string,
                                :aliases => '-u',
                                :banner  => 'USER',
                                :desc    => 'String generator template'

        class_option :usernames, :type    => :array,
                                 :aliases => '-U',
                                 :banner  => 'USER [...]',
                                 :desc    => 'Additional user-names to try'

        class_option :min_words, :type    => :numeric,
                                 :aliases => '-m',
                                 :banner  => 'MIN',
                                 :desc    => 'Minimum number of words to use'

        class_option :max_words, :type    => :numeric,
                                 :aliases => '-M',
                                 :banner  => 'MAX',
                                 :desc    => 'Maximum number of words to use'

      end
    end
  end
end
