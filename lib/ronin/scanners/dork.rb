#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2013 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/scanners/url_scanner'

require 'gscraper/search'

module Ronin
  module Scanners
    class Dork < URLScanner

      # The query types and their `GScraper::Search::Query` classes
      QUERY_TYPES = {
        web:  GScraper::Search::WebQuery,
        ajax: GScraper::Search::AJAXQuery
      }

      # The host to submit queries to
      parameter :search_host, type: String,
                              default: GScraper::Search::Query::DEFAULT_HOST,
                              description: 'The host to submit queries to'

      # The type of query to perform (`:web` or `:ajax`)
      parameter :query_type, type: Symbol,
                             default: :web,
                             description: "The type of query to perform ('web' or 'ajax')"

      # Number of seconds to pause between queries
      parameter :query_pause, type: Integer,
                              default: 2,
                              description: 'Number of seconds to pause between queries'

      # The raw query
      parameter :raw_query, type: String,
                            description: 'The raw query'

      # The search language
      parameter :language, type: String,
                           description: 'The search language'

      # Search 'link' modifier
      parameter :link, type: String,
                       description: "Search 'link' modifier"

      # Search 'related' modifier
      parameter :related, type: String,
                          description: "Search 'related' modifier"

      # Search 'info' modifier
      parameter :info, type: String,
                       description: "Search 'info' modifier"

      # Search 'site' modifier
      parameter :site, type: String,
                       description: "Search 'site' modifier"

      # Search 'filetype' modifier
      parameter :filetype, type: String,
                           description: "Search 'filetype' modifier"

      # Search 'allintitle' modifier
      parameter :allintitle, type: Array[String],
                             description: "Search 'allintitle' modifier"

      # Search 'intitle' modifier
      parameter :intitle, type: String,
                          description: "Search 'intitle' modifier"

      # Search 'allinurl' modifier
      parameter :allinurl, type: Array[String],
                           description: "Search 'allinurl' modifier"

      # Search 'inurl' modifier
      parameter :inurl, type: String,
                        description: "Search 'inurl' modifier"

      # Search 'allintext' modifier
      parameter :allintext, type: Array[String],
                            description: "Search 'allintext' modifier"

      # Search 'intext' modifier
      parameter :intext, type: String,
                         description: "Search 'intext' modifier"

      # Search for results containing the exact phrase
      parameter :exact_phrase, type: String,
                               description: 'Search for results containing the exact phrase'

      # Search for results with the words
      parameter :with_words, type: Array[String],
                             description: 'Search for results with the words'

      # Search for results with-out the words
      parameter :without_words, type: Array[String],
                                description: 'Search for results with-out the words'

      # Search for results containing the definitions of the keywords
      parameter :define, type: String,
                         description: 'Search for results containing the definitions of the keywords'

      # Search for results containing numbers between the range
      parameter :numeric_range, type: String,
                                description: 'Search for results containing numbers between the range'

      protected

      def search_options
        {
          search_host:   self.search_host,
          query:         self.raw_query,
          language:      self.language,
          link:          self.link,
          related:       self.related,
          info:          self.info,
          site:          self.site,
          filetype:      self.filetype,
          allintitle:    self.allintitle,
          intitle:       self.intitle,
          allinurl:      self.allinurl,
          inurl:         self.inurl,
          allintext:     self.allintext,
          intext:        self.intext,
          exact_phrase:  self.exact_phrase,
          with_words:    self.with_words,
          without_words: self.without_words,
          define:        self.without_words,
          numeric_range: self.numeric_range
        }
      end

      #
      # Performs the Google Dork and passes back every URL from the search
      # results.
      #
      # @yield [url]
      #   Every URL from every Page.
      #
      # @yieldparam [URI::HTTP] url
      #   A URL from the search results.
      #
      # @see http://rubydoc.info/gems/gscraper
      #
      def scan(&block)
        QUERY_TYPES.fetch(self.query_type).new(search_options) do |search|
          search.each do |page|
            page.each_url(&block)

            sleep(self.query_pause)
          end
        end
      end

    end
  end
end
