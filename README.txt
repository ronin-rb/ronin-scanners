= Ronin Scanners

* http://ronin.rubyforge.org/scanners/
* http://github.com/postmodern/ronin-scanners
* irc.freenode.net ##ronin
* Postmodern (postmodern.mod3 at gmail.com)

== DESCRIPTION:

Ronin Scanners is a Ruby library for Ronin that provides Ruby interfaces to
various third-party security scanners.

Ronin is a Ruby platform designed for information security and data
exploration tasks. Ronin allows for the rapid development and distribution
of code over many of the common Source-Code-Management (SCM) systems.

=== Free

All source code within Ronin is licensed under the GPL-2, therefore no user
will ever have to pay for Ronin or updates to Ronin. Not only is the
source code free, the Ronin project will not sell enterprise grade security
snake-oil solutions, give private training classes or later turn Ronin into
commercial software.

=== Modular

Ronin was not designed as one monolithic framework but instead as a
collection of libraries which can be individually installed. This allows
users to pick and choose what functionality they want in Ronin.

=== Decentralized

Ronin does not have a central repository of exploits and payloads which
all developers contribute to. Instead Ronin has Overlays, repositories of
code that can be hosted on any CVS/SVN/Git/Rsync server. Users can then use
Ronin to quickly install or update Overlays. This allows developers and
users to form their own communities, independent of the main developers
of Ronin.

== FEATURES/PROBLEMS:

* Provides a Rubyful interface to Nmap.
* Allows for recording of Nmap scan results using ScanDB.

== REQUIREMENTS:

* Scandb
* RProgram >= 0.1.4
* Ronin >= 0.1.2

== INSTALL:

  $ sudo gem install ronin-scanners

== EXAMPLES:

* Calling Nmap from Ruby:

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

== LICENSE:

Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
various third-party security scanners.

Copyright (c) 2008-2009 Hal Brodigan (postmodern.mod3 at gmail.com)

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
