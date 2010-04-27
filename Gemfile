source 'http://rubygems.org'
ronin_ruby = "git://github.com/ronin-ruby"

group :runtime do
  gem 'parameters',	'~> 0.2.1', :git => 'git://github.com/postmodern/parameters.git'
  gem 'nokogiri',	'~> 1.4.1'
  gem 'ruby-nmap',	'~> 0.1.0', :git => 'git://github.com/sophsec/ruby-nmap.git'
  #gem 'ruby-nikto',	'~> 0.1.0'
  gem 'ronin-ext',	'~> 0.1.0', :git => "#{ronin_ruby}/ronin-ext.git"
  gem 'ronin-int',	'~> 0.1.0', :git => "#{ronin_ruby}/ronin-int.git"
  gem 'ronin',		'~> 0.4.0', :git => "#{ronin_ruby}/ronin.git"
end

group :development do
  gem 'bundler',	'~> 0.9.19'
  gem 'rake',		'~> 0.8.7'
  gem 'jeweler',	'~> 1.4.0', :git => 'git://github.com/technicalpickles/jeweler.git'
  gem 'yard',		'~> 0.5.3'
end

gem 'rspec',	'~> 1.3.0', :group => [:development, :test]
