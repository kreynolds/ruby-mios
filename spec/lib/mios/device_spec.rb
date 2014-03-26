require 'spec_helper'

module MiOS
  module Services
    module Bar
    end
  end
end

describe MiOS::Device do
  before :each do
    states = [ { 'service' => "foo:Bar" }, { 'service' => "foo:Tar" } ]
    data = { 'id' => '1', 'states' => states }
    client = double(get:
      double(content: "{\"Device_Num_1\": #{MultiJson.dump(data)}}"))
    @output = capture_stderr do
      @device = MiOS::Device.new(client, 2, data)
    end
  end

  # it "should correctly parse service names" do
  #   output = capture_stderr do
  #     device = MiOS::Device.new(nil, '', MultiJson.load(File.read('spec/support/device_data/echo-energy-manager.json')))
  #   end
  #   expect(output).to eql "WARNING: EEMPlugin1 not yet supported\n"
  # end

  describe :initialize do
    it "should be an instance of Device" do
      expect(@device).to be_an_instance_of(MiOS::Device)
    end

    it "should output a warning for unsupported services" do
      expect(@output).to eql "WARNING: Tar not yet supported\n"
    end
  end

  describe :inspect do
    it "should return a string representation of the object" do
      expect(@device.inspect).to eql "#<MiOS::Device:0x#{'%x' % (@device.object_id << 1)} name=>"
    end
  end

  describe :method_missing do
    it "should throw an exception for missing attributes" do
      expect {@device.foo}.to raise_error
    end

    it "should not throw an exception for defined attributes" do
      @device.attributes['id'] = 1
      expect {@device.id}.to_not raise_error
      expect(@device.id).to eql 1
    end
  end

  describe :reload do
    it "should return itself" do
      expect(@device.reload).to eql @device
    end
  end

end