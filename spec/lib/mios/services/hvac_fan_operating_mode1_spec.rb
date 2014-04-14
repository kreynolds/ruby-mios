require 'spec_helper'

describe MiOS::Services::HVACFanOperatingMode1 do
  before do
    @thermostat = MiOS::Device.new(nil, MultiJson.load(File.read('spec/support/device_data/thermostat.json')))
  end

  describe :mode do
    it "should return the correct fan mode" do
      expect(@thermostat.fan_mode).to eql "Auto"
    end
  end
end