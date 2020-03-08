require 'spec_helper'

require 'ronin/scanners/udp_port_scanner'

describe Scanners::UDPPortScanner do
  let(:port) { 135 }

  subject do
    described_class.object do
      def scan
        yield '135'
      end
    end
  end

  it "should normalize results into Integers" do
    expect(subject.first).to eq(port)
  end

  it "should convert results into OpenPort resources" do
    resource = subject.each_resource.first

    expect(resource.class).to eq(OpenPort)
    expect(resource.port.protocol).to eq('udp')
    expect(resource.port.number).to eq(port)
  end
end
