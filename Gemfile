source 'https://rubygems.org'

DATA_MAPPER = 'http://github.com/datamapper'
DM_VERSION = '~> 1.0.2'
RONIN = 'http://github.com/ronin-ruby'

gem 'open_namespace',	'~> 0.3.0'
gem 'nokogiri',		'~> 1.4.1'
gem 'spidr',		'~> 0.2.4'
gem 'rprogram',		'~> 0.2.0'
gem 'ruby-nmap',	'~> 0.1.0', :git => 'http://github.com/sophsec/ruby-nmap.git'
gem 'ronin-support',	'~> 0.1.0', :git => "#{RONIN}/ronin-support.git"
gem 'ronin',		'~> 0.4.0', :git => "#{RONIN}/ronin.git"
gem 'ronin-exploits',	'~> 0.4.0', :git => "#{RONIN}/ronin-exploits.git"

group(:edge) do
  # DataMapper dependencies
  gem 'dm-migrations',	DM_VERSION, :git => 'http://github.com/postmodern/dm-migrations.git', :branch => 'runner'

  gem 'contextify',	'~> 0.1.6', :git => 'http://github.com/postmodern/contextify.git'
  gem 'ronin-gen',	'~> 0.3.0', :git => "#{RONIN}/ronin-gen.git"
end

group(:development) do
  gem 'rake',		'~> 0.8.7'
  gem 'jeweler',	'~> 1.5.0.pre'
end

group(:doc) do
  case RUBY_PLATFORM
  when 'java'
    gem 'maruku',	'~> 0.6.0'
  else
    gem 'rdiscount',	'~> 1.6.3'
  end

  gem 'dm-visualizer',		'~> 0.1.0'
  gem 'yard',			'~> 0.6.0'
  gem 'yard-contextify',	'~> 0.1.0'
  gem 'yard-parameters',	'~> 0.1.0'
end

gem 'rspec',	'~> 2.0.0.rc', :group => [:development, :test]
