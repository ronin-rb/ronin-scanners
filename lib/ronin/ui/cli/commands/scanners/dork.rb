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
# This program is distributed in the hope that it will be useful
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/ui/cli/scanner_command'
require 'ronin/scanners/dork'

module Ronin
  module UI
    module CLI
      module Commands
        module Scanners
          class Dork < ScannerCommand

            desc 'Performs Google Dorks'

            # The host to submit queries to
            scanner_option :search_host, :aliases => '-H',
                                         :banner  => 'HOST'

            # The type of query to perform (`:web` or `:ajax`)
            scanner_option :query_type, :aliases => '-t',
                                        :banner  => '[web|ajax]'

            # Number of seconds to pause between queries
            scanner_option :query_pause, :aliases => '-p',
                                         :banner  => 'SECONDS'

            # The raw query
            scanner_option :raw_query, :aliases => '-q'

            # The search language
            scanner_option :language

            # Search 'link' modifier
            scanner_option :link

            # Search 'related' modifier
            scanner_option :related

            # Search 'info' modifier
            scanner_option :info

            # Search 'site' modifier
            scanner_option :site

            # Search 'filetype' modifier
            scanner_option :filetype

            # Search 'allintitle' modifier
            scanner_option :allintitle

            # Search 'intitle' modifier
            scanner_option :intitle

            # Search 'allinurl' modifier
            scanner_option :allinurl

            # Search 'inurl' modifier
            scanner_option :inurl

            # Search 'allintext' modifier
            scanner_option :allintext

            # Search 'intext' modifier
            scanner_option :intext

            # Search for results containing the exact phrase
            scanner_option :exact_phrase

            # Search for results with the words
            scanner_option :with_words

            # Search for results with-out the words
            scanner_option :without_words

            # Search for results containing the definitions of the keywords
            scanner_option :define

            # Search for results containing numbers between the range
            scanner_option :numeric_range, :banner => 'NUM..NUM'

          end
        end
      end
    end
  end
end
