require 'spec_helper'

module MiOS
  describe Device do
    before :each do
      @states = [{ 'service' => 'foo:Bar' }, { 'service' => 'foo:Tar', 'variable' => 'switch', 'value' => 'on' }]
      data = { 'id' => '1', 'states' => @states, 'name' => 'FooBarDevice', 'category_num' => 2 }
      @interface = double(MiOS::Interface, device_status: data)
      @output = capture_stderr do
        @device = MiOS::Device.new(@interface, data)
      end
    end

    it 'should correctly parse service names' do
      output = capture_stderr do
        device = MiOS::Device.new(nil, MultiJson.load(File.read('spec/support/device_data/echo-energy-manager.json')))
      end
      expect(output).to eql "WARNING: EEMPlugin1 not yet supported\n"
    end

    describe :initialize do
      it 'should be an instance of Device' do
        expect(@device).to be_an_instance_of(MiOS::Device)
      end

      it 'should output a warning for unsupported services' do
        expect(@output).to eql "WARNING: Bar not yet supported\nWARNING: Tar not yet supported\n"
      end
    end

    describe :inspect do
      it 'should return a string representation of the object' do
        expect(@device.inspect).to eql "#<MiOS::Device:0x#{'%x' % (@device.object_id << 1)} name=FooBarDevice>"
      end
    end

    describe :method_missing do
      it 'should throw an exception for missing attributes' do
        expect {@device.foo}.to raise_error
      end

      it 'should not throw an exception for defined attributes' do
        expect {@device.id}.to_not raise_error
        expect(@device.id).to eql '1'
      end
    end

    describe :states do
      it 'should return the current device states' do
        expect(@device.states).to eql(@states)
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

    describe :attributes do
      it 'should return the attributes hash' do
        expect(@device.attributes).to eql('id' => '1', 'name' => 'FooBarDevice', 'category_num' => 2)
      end
    end

    describe :category do
      it 'should return the appropriate category' do
        expect(@device.category.label).to eql 'Lights'
      end
    end
  end
end
