require 'spec_helper'

require 'ronin/scanners/version'

describe Scanners do
  it "should have a version" do
    expect(subject.const_get('VERSION')).not_to be_nil
  end
end
