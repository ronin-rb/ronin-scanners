require 'spec_helper'
require 'helpers/database'

require 'ronin/scanners/udp_port_scanner'

describe Scanners::UDPPortScanner do
  before(:all) do
    @scanner = ronin_udp_port_scanner do

      def scan
        yield '135'
      end

    end
  end

  it "should normalize results into Integers" do
    @scanner.first.should == 135
  end

  it "should convert results into OpenPort resources" do
    resource = @scanner.each_resource.first

    resource.class.should == OpenPort
    resource.port.protocol.should == 'udp'
    resource.port.number.should == 135
  end
end
