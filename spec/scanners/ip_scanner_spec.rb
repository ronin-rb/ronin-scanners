require 'spec_helper'

require 'ronin/scanners/ip_scanner'

describe Scanners::IPScanner do
  subject do
    described_class.object do
      def scan
        yield '127.0.0.1'
      end
    end
  end

  it "should normalize results to IPAddr objects" do
    expect(subject.first).to eq(IPAddr.new('127.0.0.1'))
  end

  it "should convert results into IpAddress resources" do
    resource = subject.each_resource.first

    expect(resource.class).to eq(IPAddress)
    expect(resource.address).to eq('127.0.0.1')
  end
end
