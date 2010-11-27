require 'spec_helper'
require 'ronin/scanners/web_vulns'

describe Scanners::WebVulns do
  it "should enable all tests by default" do
    subject.enable_tests.should == Scanners::WebVulns.tests.keys
  end
end
