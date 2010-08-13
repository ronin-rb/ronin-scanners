require 'spec_helper'
require 'helpers/database'

require 'ronin/scanners/tcp_port_scanner'

describe Scanners::TCPPortScanner do
  let(:port) { 80 }

  subject do
    ronin_tcp_port_scanner do
      def scan
        yield '80'
      end
    end
  end

  it "should normalize results into Integers" do
    subject.first.should == port
  end

  it "should convert results into OpenPort resources" do
    resource = subject.each_resource.first

    resource.class.should == OpenPort
    resource.port.protocol.should == 'tcp'
    resource.port.number.should == port
  end
end
