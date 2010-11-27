#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'ronin/scanners/spider'
require 'ronin/vulns/web'

module Ronin
  module Scanners
    class WebVulns < Spider

      #
      # The tests to perform on scanned pages.
      #
      # @return [Hash{Symbol => Array<Proc>}]
      #   The tests to perform.
      #
      # @since 0.2.0
      #
      def WebVulns.tests
        @web_vuln_tests ||= Hash.new { |hash,key| hash[key] = [] }
      end

      #
      # Adds a test to the {WebVulns}. Tests should either return
      # `nil` or a `Vulns::WebVuln` resource.
      #
      # @param [Symbol] name
      #   The name of the test.
      #
      # @yield [page,callback]
      #   The given block will be passed the scanner and the page currently
      #   being scanned.
      #
      # @yieldparam [Spidr::Page] page
      #   The page currently being scanned.
      #
      # @yieldparam [Proc] callback
      #   The callback to pass back multiple `Vulns::WebVuln` objects.
      #
      # @example
      #   Ronin::Scanners::WebVulns.test do |page,callback|
      #     # ...
      #   end
      #
      # @since 0.2.0
      #
      def WebVulns.test_for(name,&block)
        WebVulns.tests[name] << block
      end

      # The tests to perform when scanning for web vulnerabilities
      parameter :enable_tests, :default => lambda { WebVulns.tests.keys },
                               :description => 'Tests to perform when scanning'

      protected

      #
      # Scans pages for web vulnerabilities.
      #
      # @yield [vuln]
      #   The given block will be passed web vulnerabilities as they are
      #   discovered.
      #
      # @yieldparam [Vulns::WebVuln, nil]
      #   A newly discovered web vulnerability.
      #
      # @since 0.2.0
      #
      def scan(&block)
        super do |page|
          @enabled_tests.each do |name|
            WebVulns.tests[name].each do |tests|
              tests.each { |test_block| test_block.call(page,block) }
            end
          end
        end
      end

      #
      # Normalizes the web vulnerability.
      #
      # @param [Vulns::Web] vuln
      #   The web vulnerability.
      #
      # @return [Vulns::Web]
      #   The web vulnerability.
      #
      # @since 0.2.0
      #
      def normalize_result(vuln)
        vuln if vuln.kind_of?(Vulns::Web)
      end

      #
      # Prepares the web vulnerability to be saved into the Database.
      #
      # @param [Vulns::Web] vuln
      #   The web vulnerability.
      #
      # @return [Vulns::Web]
      #   The web vulnerability.
      #
      # @since 0.2.0
      #
      def new_resource(vuln)
        vuln
      end

    end
  end
end
