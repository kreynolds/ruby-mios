require 'spec_helper'

describe MiOS::Services::HVACOperatingState1 do
  before do
    @thermostat = MiOS::Device.new(nil, MultiJson.load(File.read('spec/support/device_data/thermostat.json')))
  end

  describe :operating_state do
    it "should return the correct operating state" do
      expect(@thermostat.operating_state).to eql "Idle"
    end
  end
end