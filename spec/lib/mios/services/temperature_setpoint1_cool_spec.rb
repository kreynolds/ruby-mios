require 'spec_helper'

describe MiOS::Services::TemperatureSetpoint1Cool do
  before do
    @thermostat = MiOS::Device.new(nil, '', MultiJson.load(File.read('spec/support/device_data/thermostat.json')))
  end

  describe :cool_target do
    it "should return the correct target" do
      expect(@thermostat.cool_target).to eql 80
    end
  end
end