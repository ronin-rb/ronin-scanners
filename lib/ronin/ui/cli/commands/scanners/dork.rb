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
            param_option :search_host, :aliases => '-H',
                                         :banner  => 'HOST'

            # The type of query to perform (`:web` or `:ajax`)
            param_option :query_type, :aliases => '-t',
                                        :banner  => '[web|ajax]'

            # Number of seconds to pause between queries
            param_option :query_pause, :aliases => '-p',
                                         :banner  => 'SECONDS'

            # The raw query
            param_option :raw_query, :aliases => '-q'

            # The search language
            param_option :language

            # Search 'link' modifier
            param_option :link

            # Search 'related' modifier
            param_option :related

            # Search 'info' modifier
            param_option :info

            # Search 'site' modifier
            param_option :site

            # Search 'filetype' modifier
            param_option :filetype

            # Search 'allintitle' modifier
            param_option :allintitle

            # Search 'intitle' modifier
            param_option :intitle

            # Search 'allinurl' modifier
            param_option :allinurl

            # Search 'inurl' modifier
            param_option :inurl

            # Search 'allintext' modifier
            param_option :allintext

            # Search 'intext' modifier
            param_option :intext

            # Search for results containing the exact phrase
            param_option :exact_phrase

            # Search for results with the words
            param_option :with_words

            # Search for results with-out the words
            param_option :without_words

            # Search for results containing the definitions of the keywords
            param_option :define

            # Search for results containing numbers between the range
            param_option :numeric_range, :banner => 'NUM..NUM'

          end
        end
      end
    end
  end
end
