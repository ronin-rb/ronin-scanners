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
    subject.first.should == 'www.example.com'
  end

  it "should convert results into HostName resources" do
    resource = subject.each_resource.first

    resource.class.should == HostName
    resource.address.should == 'www.example.com'
  end
end
