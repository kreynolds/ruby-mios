require 'spec_helper'

describe MiOS::Services::TemperatureSetpoint1Heat do
  before do
    @thermostat = MiOS::Device.new(nil, MultiJson.load(File.read('spec/support/device_data/thermostat.json')))
  end

  describe :heat_target do
    it "should return the correct target" do
      expect(@thermostat.heat_target).to eql 68
    end
  end
end