require 'spec_helper'

require 'ronin/scanners/host_name_scanner'

describe Scanners::HostNameScanner do
  subject do
    described_class.object do
      def scan
        yield 'www.example.com'
      end
    end
  end

  it "should normalize results into Strings" do
    expect(subject.first).to eq('www.example.com')
  end

  it "should convert results into HostName resources" do
    resource = subject.each_resource.first

    expect(resource.class).to eq(HostName)
    expect(resource.address).to eq('www.example.com')
  end
end
