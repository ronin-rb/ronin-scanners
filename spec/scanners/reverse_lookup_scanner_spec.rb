require 'spec_helper'
require 'ronin/scanners/reverse_lookup_scanner'

describe Scanners::ReverseLookupScanner do
  let(:ip) { '192.0.32.10' }
  let(:host) { 'www.example.com' }

  subject { Scanners::ReverseLookupScanner.new(host: ip) }

  it "should perform reverse lookups on IP addresses" do
    expect(subject.each.to_a).to eq([host])
  end

  it "should convert host names to HostName resources" do
    resource = subject.each_resource.first

    expect(resource.class).to eq(HostName)
    expect(resource.address).to eq(host)
  end

  it "should associate HostName resources with the queried IpAddress" do
    resource = subject.each_resource.first

    expect(resource.ip_addresses[0].address).to eq(ip)
  end
end
