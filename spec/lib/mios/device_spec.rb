require 'spec_helper'

module MiOS
  describe Device do
    before :each do
      @data_request = MultiJson.load(File.read('spec/support/device_data/data_request.json'))
      @states = @data_request['devices'][11]['states']
      @attributes = MultiJson.load(File.read('spec/support/device_data/device_attributes.json'))
      VCR.use_cassette('data_request') do
        @interface =  MiOS::Interface.new('http://192.168.50.21:3480')
      end
      @interface.stub(:device_status).and_return('id' => '12', 'states' => @states, 'name' => 'On/Off Outlet')
      @device = @interface.devices[11]
    end

    describe :initialize do
      it 'should be an instance of Device' do
        expect(@device).to be_an_instance_of(MiOS::Device)
      end

      it 'should output a warning for unsupported services' do
        output = capture_stderr do
          device = MiOS::Device.new(nil, MultiJson.load(File.read('spec/support/device_data/echo-energy-manager.json')))
        end
        expect(output).to eql "WARNING: EEMPlugin1 not yet supported\n"
      end
    end

    describe :inspect do
      it 'should return a string representation of the object' do
        expect(@device.inspect).to eql "#<MiOS::Device:0x#{'%x' % (@device.object_id << 1)} name=On/Off Outlet>"
      end
    end

    describe :method_missing do
      it 'should throw an exception for missing attributes' do
        expect {@device.foo}.to raise_error
      end

      it 'should not throw an exception for defined attributes' do
        expect {@device.id}.to_not raise_error
        expect(@device.id).to eql '12'
      end
    end

    describe :states do
      it 'should return the current device states' do
        expect(@device.states).to eql(@states)
      end
    end

    describe :room do
      it 'should return the correct room for the device' do
        expect(@device.room.name).to eql 'Living Room'
      end
    end

    describe :reload do
      it 'should change state' do
        expect(@device.states).to eql(@states)
        @states[1]['value'] = 'off'
        @device.reload
        expect(@device.states).to eql(@states)
      end
    end

    describe :category do
      it 'should return the appropriate category' do
        expect(@device.category.label).to eql 'Lights'
      end
    end

    describe :attributes do
      it 'should return the attributes hash' do
        expect(@device.attributes).to eql(@attributes)
      end
    end
  end
end
