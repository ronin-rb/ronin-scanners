# Ronin Scanners

* [Source](http://github.com/ronin-ruby/ronin-scanners)
* [Issues](http://github.com/ronin-ruby/ronin-scanners/issues)
* [Documentation](http://rubydoc.info/github/ronin-ruby/ronin-scanners/frames)
* [Mailing List](http://groups.google.com/group/ronin-ruby)
* [irc.freenode.net #ronin](http://webchat.freenode.net/?channels=ronin&uio=Mj10cnVldd)

## Description

Ronin Scanners is a Ruby library for Ronin that provides Ruby interfaces to
various third-party security scanners.

Ronin is a Ruby platform for exploit development and security research.
Ronin allows for the rapid development and distribution of code, exploits
or payloads over many common Source-Code-Management (SCM) systems.

### Ruby

Ronin's Ruby environment allows security researchers to leverage Ruby with
ease. The Ruby environment contains a multitude of convenience methods
for working with data in Ruby, a Ruby Object Database, a customized Ruby
Console and an extendable command-line interface.

### Extend

Ronin's more specialized features are provided by additional Ronin
libraries, which users can choose to install. These libraries can allow
one to write and run Exploits and Payloads, scan for PHP vulnerabilities,
perform Google Dorks  or run 3rd party scanners.

### Publish

Ronin allows users to publish and share code, exploits, payloads or other
data via Overlays. Overlays are directories of code and data that can be
hosted on any SVN, Hg, Git or Rsync server. Ronin makes it easy to create,
install or update Overlays.

## Features

* Provides various Scanner base-classes:
  * {Ronin::Scanners::Scanner}
  * {Ronin::Scanners::IPScanner}
  * {Ronin::Scanners::HostNameScanner}
  * {Ronin::Scanners::TCPPortScanner}
  * {Ronin::Scanners::UDPPortScanner}
  * {Ronin::Scanners::URLScanner}
  * {Ronin::Scanners::CredentialScanner}
* Provides various specialized Scanner classes:
  * {Ronin::Scanners::ResolvScanner}
  * {Ronin::Scanners::ReverseLookupScanner}
  * {Ronin::Scanners::SiteMap}
  * {Ronin::Scanners::Spider}
  * {Ronin::Scanners::Nmap}
  * {Ronin::Scanners::Proxies}

## Synopsis

Start the Ronin console with Ronin Scanners preloaded:

    $ ronin-scanners

## Examples

Calling Nmap from Ruby:

    require 'ronin/scanners/nmap'
  
    Scanners::Nmap.scan(:targets => 'www.google.com', :ports => [80,21,25], :service_scan => true)
    # Starting Nmap 4.68 ( http://nmap.org ) at 2009-01-09 16:51 PST
    # Interesting ports on mh-in-f99.google.com (209.85.173.99):
    # PORT   STATE    SERVICE VERSION
    # 21/tcp filtered ftp
    # 25/tcp filtered smtp
    # 80/tcp open     http    Google httpd 1.3 (GFE)
    # Service Info: OS: Linux
    #
    # Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
    # Nmap done: 1 IP address (1 host up) scanned in 11.627 seconds
    # => nil

## Requirements

* [open_namespace](http://github.com/postmodern/open_namespace) ~> 0.3
* [rprogram](http://github.com/postmodern/rprogram) ~> 0.3
* [ruby-nmap](http://github.com/sophsec/ruby-nmap/) ~> 0.5
* [net-ssh](http://github.com/net-ssh/net-ssh) ~> 2.1
* [nokogiri](http://github.com/tenderlove/nokogiri) ~> 1.4
* [spidr](http://github.com/postmodern/spidr) ~> 0.3
* [ronin-support](http://github.com/ronin-ruby/ronin-support) ~> 0.4
* [ronin](http://github.com/ronin-ruby/ronin) ~> 1.3

## Install

    $ sudo gem install ronin-scanners

## License

Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
various third-party security scanners.

Copyright (c) 2008-2011 Hal Brodigan (postmodern.mod3 at gmail.com)

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
