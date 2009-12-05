# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'hoe/signing'
require './tasks/spec.rb'
require './tasks/yard.rb'

Hoe.spec('ronin-scanners') do
  self.rubyforge_name = 'ronin'
  self.developer('Postmodern', 'postmodern.mod3@gmail.com')
  self.remote_rdoc_dir = 'docs/ronin-scanners'
  self.extra_deps = [
    ['rprogram', '>=0.1.7'],
    ['ruby-nmap', '>=0.1.0'],
    ['ronin', '>=0.3.0']
  ]

  self.extra_dev_deps = [
    ['rspec', '>=1.1.12'],
    ['yard', '>=0.4.0']
  ]

  self.spec_extras = {:has_rdoc => 'yard'}
end

# vim: syntax=Ruby
