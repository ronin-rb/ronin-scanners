require 'spec_helper'
require 'ronin/scanners/resolv_scanner'

describe Scanners::ResolvScanner do
  before(:all) do
    @scanner = Scanners::ResolvScanner.new
  end

  it "should resolv hostnames to IP addresses" do
    @scanner.host = 'www.example.com'

    @scanner.each.to_a.should == [IPAddr.new('192.0.32.10')]
  end
end
