source 'https://rubygems.org'

RONIN = 'git://github.com/ronin-ruby'

group(:runtime) do
  gem 'open_namespace',	'~> 0.3.0'
  gem 'parameters',	'~> 0.2.1'
  gem 'nokogiri',	'~> 1.4.1'
  gem 'spidr',		'~> 0.2.4'
  gem 'rprogram',	'~> 0.1.8'
  gem 'ruby-nmap',	'~> 0.1.0', :git => 'git://github.com/sophsec/ruby-nmap.git'
  gem 'ronin-support',	'~> 0.1.0', :git => "#{RONIN}/ronin-support.git"
  gem 'ronin',		'~> 0.4.0', :git => "#{RONIN}/ronin.git"
end

group(:development) do
  gem 'bundler',	'~> 0.9.24'
  gem 'rake',		'~> 0.8.7'
  gem 'jeweler',	'~> 1.4.0', :git => 'git://github.com/technicalpickles/jeweler.git'
end

group(:doc) do
  case RUBY_PLATFORM
  when 'java'
    gem 'maruku',	'~> 0.6.0'
  else
    gem 'rdiscount',	'~> 1.6.3'
  end

  gem 'ruby-graphviz',	'~> 0.9.10'
  gem 'dm-visualizer',	'~> 0.1.0'
  gem 'yard',		'~> 0.5.3'
  gem 'yard-contextify','~> 0.1.0', :git => 'git://github.com/postmodern/yard-contextify.git'
  gem 'yard-parameters','~> 0.1.0'
end

gem 'rspec',	'~> 1.3.0', :group => [:development, :test]
