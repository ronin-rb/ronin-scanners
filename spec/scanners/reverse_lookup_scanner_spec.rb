require 'spec_helper'
require 'ronin/scanners/reverse_lookup_scanner'

describe Scanners::ReverseLookupScanner do
  before(:all) do
    @scanner = Scanners::ReverseLookupScanner.new
  end

  it "should perform reverse lookups on IP addresses" do
    @scanner.host = '192.0.32.10'

    @scanner.each.to_a.should == ['www.example.com']
  end
end
