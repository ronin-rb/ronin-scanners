require 'spec_helper'
require 'ronin/scanners/resolv_scanner'

describe Scanners::ResolvScanner do
  before(:all) do
    @host = 'www.example.com'
    @ip = IPAddr.new('192.0.32.10')

    @scanner = Scanners::ResolvScanner.new(:host => @host)
  end

  it "should resolv hostnames to IP addresses" do
    @scanner.each.to_a.should == [@ip]
  end

  it "should convert IP addresses to IpAddress resources" do
    resource = @scanner.each_resource.first

    resource.class.should == INT::IpAddress
    resource.address.should == @ip
  end

  it "should associate IpAddress resources with HostNames" do
    resource = @scanner.each_resource.first

    resource.host_names[0].address.should == @host
  end
end
