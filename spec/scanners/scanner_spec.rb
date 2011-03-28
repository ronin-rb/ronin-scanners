require 'spec_helper'

require 'ronin/scanners/scanner'

describe Scanners::Scanner do
  subject { Scanners::Scanner }

  it "should be cacheable" do
    should < Model::Cacheable
  end

  it "should allow parameters" do
    should < Parameters
  end

  it "should be Enumerable" do
    should < Enumerable
  end

  describe "each" do
    subject do
      described_class.object do
        def scan
          yield 1
          yield 3
          yield 11
          yield nil
        end

        def normalize_result(result)
          if result < 10
            result * 2
          end
        end
      end
    end

    it "should skip nil results" do
      results = []

      subject.each { |i| results << i }

      results.should_not include(nil)
    end

    it "should normalize the results" do
      results = []

      subject.each { |i| results << i }

      results.should_not include(1)
      results.should_not include(3)
      results.should_not include(11)
    end

    it "should skip normalized results which are nil" do
      results = []

      subject.each { |i| results << i }

      results.should_not include(22)
      results.should_not include(nil)
    end

    it "should return an Enumerator if no block is given" do
      subject.each.class.should == Enumerator
    end

    it "should enumerate over Ruby primitives" do
      results = []

      subject.each { |i| results << i }

      results.should == [2, 6]
    end
  end

  describe "each_resource" do
    subject { described_class.new }

    it "should return an Enumerator if no block is given" do
      subject.each_resource.class.should == Enumerator
    end
  end

  describe "save_each" do
    subject { described_class.new }

    it "should return an Enumerator if no block is given" do
      subject.save_each.class.should == Enumerator
    end
  end
end
