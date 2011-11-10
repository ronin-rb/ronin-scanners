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

require 'ronin/extensions/file'
require 'ronin/scanners/scanner'
require 'ronin/credential'
require 'ronin/fuzzing'

module Ronin
  module Scanners
    #
    # The {CredentialScanner} class represents scanners that yield
    # `Credential` results and resources.
    #
    # @since 1.0.0
    #
    class CredentialScanner < Scanner

      # Paths to a word-list file(s)
      parameter :wordlists, :type => Array[String],
                            :default => [],
                            :description => 'Wordlist file(s) to use'

      # Mutation rules to apply to words from the {#wordlist}
      parameter :mutations, :default => {},
                            :description => 'Hash of mutations to perform'

      # String generator template
      parameter :generator, :type => Array,
                            :description => 'String generator template'

      protected

      #
      # Reads each line from a wordlist file.
      #
      # @param [String] path
      #   The path to the wordlist file.
      #
      # @yield [word]
      #   The given block will be passed each word from the file.
      #
      # @yieldparam [String] word
      #   A word from the wordlist.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      # @api semipublic
      #
      def wordlist(path,&block)
        File.each_line(path,&block)
      end

      #
      # Iterates over each word from the {#wordlist} or String {#generator}.
      #
      # @yield [word]
      #   The given block will be passed each word.
      #
      # @yieldparam [String] word
      #   A word from the {#wordlist} or String {#generator}.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      # @api semipublic
      #
      def each_word(&block)
        return enum_for(:each_word) unless block

        if self.wordlists
          self.wordlists.each do |path|
            wordlist(path) do |word|
              unless self.mutations.empty?
                word.mutate(mutations,&block)
              else
                yield word
              end
            end
          end
        end

        if self.generator
          String.generate(self.generator,&block)
        end
      end

      #
      # Iterates over every n words.
      #
      # @param [Integer, Range, Array] n
      #   The number of words to combine.
      #
      # @yield [words]
      #   The given block will be passed every combination of `n` words.
      #
      # @yieldparam [String]
      #    The combination of `n` words.
      #
      # @return [Enumerator]
      #   If no block is given, an Enumerator will be returned.
      #
      # @api semipublic
      #
      def each_n_words(n,&block)
        String.generate([each_word, n],&block)
      end

    end
  end
end
