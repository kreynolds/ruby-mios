require 'spec_helper'

describe "interface" do
  let(:mios) { MiOS::Interface.new('http://192.168.50.21:3480') }
  let(:example_data_request) { MultiJson.load(File.read('spec/support/device_data/data_request.json')) }
  let(:example_device_names) { ["ZWave", "_Scene Controller", "Thermostat", "Caddx NX584 Security System",
                                "Outdoor Switch", "_GE Advanced Remote", "Serial_Portlist_2146893057",
                                "ftdi_sio", "Partition 1", "Zone 1", "Generic IP Camera", "On/Off Outlet",
                                "_Home Energy Monitor", "_Home Energy Monitor Clamp 1",
                                "_Home Energy Monitor Clamp 2", "Ergy"] }

  describe :initialize do
    context 'when vera unit is available' do
      it 'should load all the devices' do
        VCR.use_cassette('data_request') do
          expect(mios.devices.length).to eql 16
        end
      end

      it 'should load the vera attributes' do
        VCR.use_cassette('data_request') do
          expect(mios.attributes.length).to eql 29
        end
      end
    end

    context 'when vera unit is not available' do
      it 'should throw an exception' do
        VCR.use_cassette('data_request_failure') do
          expect{ mios }.to raise_exception 'Device not available'
        end
      end
    end
  end

  describe :refresh! do
    context 'when vera unit is available' do
      it 'should refresh all the devices' do
        VCR.use_cassette('data_request', :allow_playback_repeats => true) do
          # TODO: need to change something in the devices and verify that it
          # returns back to original value
          mios.refresh!
          expect(mios.devices.length).to eql 16
        end
      end

      it 'should refresh the vera attributes' do
        VCR.use_cassette('data_request', :allow_playback_repeats => true) do
          # TODO: need to change something in the attributes and verify that it
          # returns back to original value
          mios.refresh!
          expect(mios.attributes.length).to eql 29
        end
      end
    end
  end

  describe :devices do
    it 'should return an array of devices' do
      VCR.use_cassette('data_request') do
        expect(mios.devices).to be_an(Array)
        expect(mios.devices.length).to eql 16
      end
    end
  end

  describe :device_names do
    it 'should return an array of device names' do
      VCR.use_cassette('data_request') do
        expect(mios.device_names).to eql example_device_names
      end
    end
  end

  describe :categories do
    it 'should return an array of categories' do
      pending 'none of the devices respond to :category so this just blows up.'
      VCR.use_cassette('data_request') do
        expect(mios.categories).to eql ""
      end
    end
  end

  describe :method_missing do
    it 'should return values from the attributes when asked' do
      VCR.use_cassette('data_request') do
        expect(mios.model).to eql "MiCasaVerde VeraLite"
      end
    end

    it 'should throw method not found error if not found in attributes' do
      VCR.use_cassette('data_request') do
        expect{ mios.foo }.to raise_exception
      end
    end
  end
end
