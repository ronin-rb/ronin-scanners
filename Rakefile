require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'
require './lib/ronin/scanners/version.rb'

Jeweler::Tasks.new do |gem|
  gem.name = 'ronin-scanners'
  gem.version = Ronin::Scanners::VERSION
  gem.licenses = ['GPL-2']
  gem.summary = %Q{A Ruby library for Ronin that provides Ruby interfaces to various third-party security scanners.}
  gem.description = %Q{Ronin Scanners is a Ruby library for Ronin that provides Ruby interfaces to various third-party security scanners.}
  gem.email = 'ronin-ruby@googlegroups.com'
  gem.homepage = 'http://github.com/ronin-ruby/ronin-scanners'
  gem.authors = ['Postmodern']
  gem.has_rdoc = 'yard'
end
Jeweler::GemcutterTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

require 'dm-visualizer/rake/graphviz_task'
DataMapper::Visualizer::Rake::GraphVizTask.new(
  :bundle => [:runtime],
  :include => ['lib'],
  :require => ['ronin/scanners']
)

require 'yard'
YARD::Rake::YardocTask.new
