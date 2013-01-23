require 'spec_helper'
require 'ronin/scanners/reverse_lookup_scanner'

describe Scanners::ReverseLookupScanner do
  let(:ip) { '192.0.32.10' }
  let(:host) { 'www.example.com' }

  subject { Scanners::ReverseLookupScanner.new(host: ip) }

  it "should perform reverse lookups on IP addresses" do
    subject.each.to_a.should == [host]
  end

  it "should convert host names to HostName resources" do
    resource = subject.each_resource.first

    resource.class.should == HostName
    resource.address.should == host
  end

  it "should associate HostName resources with the queried IpAddress" do
    resource = subject.each_resource.first

    resource.ip_addresses[0].address.should == ip
  end
end
