require 'ronin/scanners/scanner'

require 'spec_helper'
require 'helpers/database'

describe Scanners::Scanner do
  it "should be cacheable" do
    Scanners::Scanner.should include(Platform::Cacheable)
  end

  it "should allow parameters" do
    Scanners::Scanner.should include(Parameters)
  end

  it "should be Enumerable" do
    Scanners::Scanner.should include(Enumerable)
  end

  describe "each" do
    before(:all) do
      @scanner = ronin_scanner do

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

      @scanner.each { |i| results << i }

      results.should_not include(nil)
    end

    it "should normalize the results" do
      results = []

      @scanner.each { |i| results << i }

      results.should_not include(1)
      results.should_not include(3)
      results.should_not include(11)
    end

    it "should skip normalized results which are nil" do
      results = []

      @scanner.each { |i| results << i }

      results.should_not include(22)
      results.should_not include(nil)
    end

    it "should return an Enumerator if no block is given" do
      @scanner.each.class.should == Enumerator
    end

    it "should enumerate over Ruby primitives" do
      results = []

      @scanner.each { |i| results << i }

      results.should == [2, 6]
    end
  end

  describe "each_resource" do
    before(:all) do
      @scanner = ronin_scanner do
      end
    end

    it "should return an Enumerator if no block is given" do
      @scanner.each_resource.class.should == Enumerator
    end
  end

  describe "import_each" do
    before(:all) do
      @scanner = ronin_scanner do
      end
    end

    it "should return an Enumerator if no block is given" do
      @scanner.import_each.class.should == Enumerator
    end
  end
end
