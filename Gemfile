source 'https://rubygems.org'

DM_URI = 'http://github.com/datamapper'
DM_VERSION = '~> 1.1.0'
RONIN_URI = 'http://github.com/ronin-ruby'

gemspec

gem 'data_paths', '~> 0.3.0', :git => 'git://github.com/postmodern/data_paths.git'
gem 'wordlist', '~> 0.2.0', :git => 'git://github.com/sophsec/wordlist.git',
                            :branch => 'refactor'

# Ronin dependencies
gem 'ronin-support',	'~> 0.2', :git => "#{RONIN_URI}/ronin-support.git"
gem 'ronin',		      '~> 1.1', :git => "#{RONIN_URI}/ronin.git"
gem 'ronin-gen',	    '~> 1.0', :git => "#{RONIN_URI}/ronin-gen.git"
gem 'ronin-exploits',	'~> 1.0', :git => "#{RONIN_URI}/ronin-exploits.git"

group :development do
  gem 'rake',		      '~> 0.8.7'

  gem 'ore-tasks',	  '~> 0.4'
  gem 'rspec',		    '~> 2.4'

  gem 'kramdown',         '~> 0.12'
  gem 'dm-visualizer',		'~> 0.2.0'
end
