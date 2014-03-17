require 'spec_helper'

describe MiOS::Services::EnergyMetering1 do
  before do
    @meter = MiOS::Device.new(nil, '', MultiJson.load(File.read('spec/support/device_data/power-meter.json')))
  end

  describe :watts do
    it "should return the correct power value" do
      expect(@meter.watts).to eql 501
    end
  end

  describe :kWh do
    it "should return the correct energy value" do
      expect(@meter.kWh).to eql 22.1990
    end
  end

  describe :last_reading_at do
    it "should return the correct time the last energy value was read" do
      expect(@meter.last_reading_at).to eql Time.at(1395006325)
    end
  end

end