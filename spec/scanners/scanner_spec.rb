require 'ronin/scanners/scanner'

require 'spec_helper'

describe Scanners::Scanner do
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

    it "should be enumerable" do
      @scanner.kind_of?(Enumerable)
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
  end

  describe "import_each" do
    before(:all) do
      @scanner = ronin_scanner do
      end
    end
  end
end
