require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:runtime, :test)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rspec'
require 'ronin/database/migrations/scanners'
require 'ronin/spec/database'
require 'ronin/scanners/version'

include Ronin
