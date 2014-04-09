require 'spec_helper'

describe "interface" do
  it "should load all the devices" do
    VCR.use_cassette('data_request') do
      mios = MiOS::Interface.new('http://192.168.50.21:3480')
      expect(mios.devices.length).to eql 16
    end
  end

  it "should turn on the light" do
    VCR.use_cassette('turn_on_light') do
      mios = MiOS::Interface.new('http://192.168.50.21:3480')
      mios.devices[11].on! do
        expect(mios.devices[11]).to be_on
      end
    end
  end

  it "should turn off the light" do
    VCR.use_cassette('turn_off_light') do
      mios = MiOS::Interface.new('http://192.168.50.21:3480')
      mios.devices[11].off! do
        expect(mios.devices[11]).to be_off
      end
    end
  end

  describe :data_request do
    it "should return the state of the vera" do
      VCR.use_cassette('data_request', :allow_playback_repeats => true) do
        vera = MiOS::Interface.new('http://192.168.50.21:3480')
        expect(vera.data_request).to eql MultiJson.load(File.read('spec/support/device_data/data_request.json'))
      end
    end
  end

end

