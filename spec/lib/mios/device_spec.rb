require 'spec_helper'

describe "device" do
  it "should correctly parse service names" do
    output = capture_stderr do
      device = MiOS::Device.new(nil, '', MultiJson.load(File.read('spec/support/device_data/echo-energy-manager.json')))
    end
    expect(output).to eql "WARNING: EEMPlugin1 not yet supported\n"
  end
end