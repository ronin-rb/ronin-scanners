require 'ronin/scanners/version'

require 'spec_helper'

describe Ronin do
  it "should have a version" do
    @version = Ronin::Scanners.const_get('VERSION')
    @version.should_not be_nil
    @version.should_not be_empty
  end
end
