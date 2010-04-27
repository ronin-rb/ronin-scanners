require 'ronin/scanners/tcp_port_scanner'

require 'spec_helper'
require 'helpers/database'

describe Scanners::TCPPortScanner do
  before(:all) do
    @scanner = ronin_tcp_port_scanner do

      def scan
        yield '80'
      end

    end
  end

  it "should normalize results into Integers" do
    @scanner.first.should == 80
  end

  it "should convert results into OpenPort resources" do
    resource = @scanner.each_resource.first

    resource.class.should == INT::OpenPort
    resource.port.protocol.should == 'tcp'
    resource.port.number.should == 80
  end
end
