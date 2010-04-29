require 'spec_helper'
require 'helpers/database'

require 'ronin/scanners/url_scanner'

describe Scanners::URLScanner do
  before(:all) do
    @scanner = ronin_url_scanner do

      def scan
        yield 'http://www.example.com/path?bla=1'
      end

    end
  end

  it "should normalize results into URI objects" do
    url = @scanner.first

    url.class.should == URI::HTTP
    url.scheme.should == 'http'
    url.host.should == 'www.example.com'
    url.port.should == 80
    url.path.should == '/path'
    url.query.should == 'bla=1'
  end

  it "should convert results into Url resources" do
    resource = @scanner.each_resource.first

    resource.class.should == INT::URL
    resource.scheme.should == 'http'
    resource.host_name.address.should == 'www.example.com'
    resource.port.number.should == 80
    resource.path.should == '/path'
    resource.query_string.should == 'bla=1'
  end
end
