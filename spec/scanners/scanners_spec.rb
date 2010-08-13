require 'spec_helper'

require 'ronin/scanners/version'

describe Scanners do
  it "should have a version" do
    subject.const_get('VERSION').should_not be_nil
  end
end
