require 'spec_helper'

describe MiOS::Client do

  it "can be instantiated" do
    client = MiOS::Client.new('0.0.0.0:3000')
    expect(client).to be_a MiOS::Client
  end

  describe "#data_request" do
    let(:client) { MiOS::Client.new('http://192.168.50.21:3480') }
    let(:data_request_json) { MultiJson.load(File.read('spec/support/device_data/data_request.json')) }

    it "returns ruby object from parsed json" do
      VCR.use_cassette('data_request') do
        test_params = {:id => "user_data", :output_format => :json}
        expect(client.data_request(test_params)).to eq data_request_json # MultiJson.load(File.read('spec/support/device_data/data_request.json'))
      end
    end

    it "defaults to json output format" do
      VCR.use_cassette('data_request') do
        test_params = {:id => "user_data"}
        expect(client.data_request(test_params)).to eq data_request_json
      end
    end
  end
end