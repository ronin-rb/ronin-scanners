require 'spec_helper'

require 'ronin/scanners/scanner'

describe Scanners::Scanner do
  subject { Scanners::Scanner }

  it "should be cacheable" do
    should < Script
  end

  it "should be Enumerable" do
    should < Enumerable
  end

  describe "#each" do
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

      expect(results).not_to include(nil)
    end

    it "should normalize the results" do
      results = []

      subject.each { |i| results << i }

      expect(results).not_to include(1)
      expect(results).not_to include(3)
      expect(results).not_to include(11)
    end

    it "should skip normalized results which are nil" do
      results = []

      subject.each { |i| results << i }

      expect(results).not_to include(22)
      expect(results).not_to include(nil)
    end

    it "should return an Enumerator if no block is given" do
      expect(subject.each.class).to eq(Enumerator)
    end

    it "should enumerate over Ruby primitives" do
      results = []

      subject.each { |i| results << i }

      expect(results).to eq([2, 6])
    end
  end

  describe "#each_resource" do
    subject { described_class.new }

    it "should return an Enumerator if no block is given" do
      expect(subject.each_resource.class).to eq(Enumerator)
    end
  end

  describe "#import" do
    subject { described_class.new }

    it "should return an Enumerator if no block is given" do
      expect(subject.import.class).to eq(Enumerator)
    end
  end
end
