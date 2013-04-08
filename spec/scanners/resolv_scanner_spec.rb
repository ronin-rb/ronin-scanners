require 'spec_helper'
require 'ronin/scanners/resolv_scanner'

describe Scanners::ResolvScanner do
  let(:host) { 'localhost' }
  let(:ip)   { IPAddr.new('127.0.0.1') }

  subject { Scanners::ResolvScanner.new(host: host) }

  it "should resolv hostnames to IP addresses" do
    subject.each.to_a.should include(ip)
  end

  it "should convert IP addresses to IpAddress resources" do
    subject.each_resource.any? { |resource|
      resource.kind_of?(IPAddress) && resource.address == ip
    }.should be_true
  end

  it "should associate IpAddress resources with HostNames" do
    subject.each_resource.any? { |resource|
      resource.host_names[0].address == host
    }.should be_true
  end
end
