require 'spec_helper'

describe MiOS::Services::HVACUserOperatingMode1 do
  before do
    @thermostat = MiOS::Device.new(nil, MultiJson.load(File.read('spec/support/device_data/thermostat.json')))
  end

  describe :mode do
    it "should return the correct operating mode" do
      expect(@thermostat.mode).to eql "HeatOn"
    end
  end
end