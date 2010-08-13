require 'spec_helper'
require 'ronin/scanners/resolv_scanner'

describe Scanners::ResolvScanner do
  let(:host) { 'www.example.com' }
  let(:ip) { IPAddr.new('192.0.32.10') }

  subject { Scanners::ResolvScanner.new(:host => host) }

  it "should resolv hostnames to IP addresses" do
    subject.each.to_a.should == [ip]
  end

  it "should convert IP addresses to IpAddress resources" do
    resource = subject.each_resource.first

    resource.class.should == IPAddress
    resource.address.should == ip
  end

  it "should associate IpAddress resources with HostNames" do
    resource = subject.each_resource.first

    resource.host_names[0].address.should == host
  end
end
