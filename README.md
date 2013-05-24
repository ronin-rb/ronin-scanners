# Ronin Scanners

* [Source](https://github.com/ronin-ruby/ronin-scanners)
* [Issues](https://github.com/ronin-ruby/ronin-scanners/issues)
* [Documentation](http://rubydoc.info/github/ronin-ruby/ronin-scanners/frames)
* [Mailing List](https://groups.google.com/group/ronin-ruby)
* [irc.freenode.net #ronin](http://ronin-ruby.github.com/irc/)

[![Build Status](https://secure.travis-ci.org/ronin-ruby/ronin-scanners.png?branch=master)](https://travis-ci.org/ronin-ruby/ronin-scanners)

## Description

Ronin Scanners is a Ruby library for Ronin that provides Ruby interfaces to
various third-party security scanners.

[Ronin] is a Ruby platform for exploit development and security research.
Ronin allows for the rapid development and distribution of code, exploits
or payloads over many common Source-Code-Management (SCM) systems.

## Features

* Provides various Scanner base-classes:
  * {Ronin::Scanners::Scanner}
  * {Ronin::Scanners::IPScanner}
  * {Ronin::Scanners::HostNameScanner}
  * {Ronin::Scanners::TCPPortScanner}
  * {Ronin::Scanners::UDPPortScanner}
  * {Ronin::Scanners::URLScanner}
* Provides various specialized Scanner classes:
  * {Ronin::Scanners::Dork}
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
  
    Scanners::Nmap.scan(targets: 'www.google.com', ports: [80,21,25], service_scan: true)
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
    # => [#<Ronin::IPAddress: 216.52.208.185>]

Importing Nmap scan results into the Database:

    ips = Scanners::Nmap.import(targets: 'www.google.com', ports: [80,21,25], service_scan: true)
    # => [#<Ronin::IPAddress: 216.52.208.185>]
    ips[0].host_names
    # => [#<Ronin::HostName: www.google.com>, #<Ronin::HostName: pd-in-f103.1e100.net>]
    ips[0].ports
    # => [#<Ronin::Port: 80/tcp>]

## Requirements

* [Ruby] >= 1.9.1
* [open_namespace] ~> 0.3
* [ruby-nmap] ~> 0.6
* [net-ssh] ~> 2.1
* [nokogiri] ~> 1.4
* [net-http-persistent] ~> 2.0
* [spidr] ~> 0.3
* [gscraper] ~> 0.4
* [ronin-support] ~> 0.5
* [ronin] ~> 1.6

## Install

### Stable

    $ gem install ronin-scanners

### Edge

    $ git clone git://github.com/ronin-ruby/ronin-scanners.git
    $ cd ronin-scanners/
    $ bundle install
    $ ./bin/ronin-scan-nmap --help

## License

Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
various third-party security scanners.

Copyright (c) 2008-2013 Hal Brodigan (postmodern.mod3 at gmail.com)

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

[Ruby]: http://www.ruby-lang.org
[Ronin]: http://ronin-ruby.github.com/

[open_namespace]: https://github.com/postmodern/open_namespace#readme
[ruby-nmap]: https://github.com/sophsec/ruby-nmap#readme
[net-ssh]: https://github.com/net-ssh/net-ssh#readme
[nokogiri]: https://github.com/tenderlove/nokogiri#readme
[net-http-persistent]: http://docs.seattlerb.org/net-http-persistent
[spidr]: https://github.com/postmodern/spidr#readme
[gscraper]: https://github.com/postmodern/gscraper#readme
[ronin-support]: https://github.com/ronin-ruby/ronin-support#readme
[ronin]: https://github.com/ronin-ruby/ronin#readme
