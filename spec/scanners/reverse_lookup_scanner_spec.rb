require 'spec_helper'
require 'ronin/scanners/reverse_lookup_scanner'

describe Scanners::ReverseLookupScanner do
  before(:all) do
    @ip = '192.0.32.10'
    @host = 'www.example.com'

    @scanner = Scanners::ReverseLookupScanner.new(:host => @ip)
  end

  it "should perform reverse lookups on IP addresses" do
    @scanner.each.to_a.should == [@host]
  end

  it "should convert host names to HostName resources" do
    resource = @scanner.each_resource.first

    resource.class.should == INT::HostName
    resource.address.should == @host
  end

  it "should associate HostName resources with the queried IpAddress" do
    resource = @scanner.each_resource.first

    resource.ip_addresses[0].address.should == @ip
  end
end
