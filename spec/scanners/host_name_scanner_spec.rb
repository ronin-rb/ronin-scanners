require 'ronin/scanners/host_name_scanner'

require 'spec_helper'
require 'helpers/database'

describe Scanners::HostNameScanner do
  before(:all) do
    @scanner = ronin_host_name_scanner do

      def scan
        yield 'www.example.com'
      end

    end
  end

  it "should normalize results into Strings" do
    @scanner.first.should == 'www.example.com'
  end

  it "should convert results into HostName resources" do
    resource = @scanner.each_resource.first

    resource.class.should == INT::HostName
    resource.address.should == 'www.example.com'
  end
end
