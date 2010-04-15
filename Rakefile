require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:runtime, :development)
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
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/ronin-ruby/ronin-scanners'
  gem.authors = ['Postmodern']
  gem.has_rdoc = 'yard'
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
