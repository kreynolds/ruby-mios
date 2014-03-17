require 'spec_helper'

describe "interface" do
  it "should load all the devices" do
    VCR.use_cassette('data_request') do
      mios = MiOS::Interface.new('http://192.168.50.21:3480')
      expect(mios.devices.length).to eql 16
    end    
  end
end

