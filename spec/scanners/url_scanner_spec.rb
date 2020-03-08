require 'spec_helper'

require 'ronin/scanners/url_scanner'

describe Scanners::URLScanner do
  let(:url) { URI('http://www.example.com/path?bla=1') }

  subject do
    described_class.object do
      def scan
        yield 'http://www.example.com/path?bla=1'
      end
    end
  end

  it "should normalize results into URI objects" do
    result = subject.first

    expect(result.class).to eq(URI::HTTP)
    expect(result.scheme).to eq(url.scheme)
    expect(result.host).to eq(url.host)
    expect(result.port).to eq(url.port)
    expect(result.path).to eq(url.path)
    expect(result.query).to eq(url.query)
  end

  it "should convert results into Url resources" do
    resource = subject.each_resource.first

    expect(resource.class).to eq(URL)
    expect(resource.scheme.name).to eq(url.scheme)
    expect(resource.host_name.address).to eq(url.host)
    expect(resource.port.number).to eq(url.port)
    expect(resource.path).to eq(url.path)
    expect(resource.query_string).to eq(url.query)
  end
end
