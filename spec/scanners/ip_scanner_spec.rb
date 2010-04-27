require 'ronin/scanners/ip_scanner'

require 'spec_helper'
require 'helpers/database'

describe Scanners::IPScanner do
  before(:all) do
    @scanner = ronin_ip_scanner do

      def scan
        yield '127.0.0.1'
      end

    end
  end

  it "should normalize results to IPAddr objects" do
    @scanner.first.should == IPAddr.new('127.0.0.1')
  end

  it "should convert results into INT::IpAddress resources" do
    resource = @scanner.each_resource.first

    resource.class.should == INT::IpAddress
    resource.address.should == '127.0.0.1'
  end
end
