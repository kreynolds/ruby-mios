require 'spec_helper'

module MiOS
  describe Interface do
    let(:mios) { MiOS::Interface.new('http://192.168.50.21:3480') }
    let(:example_data_request) { MultiJson.load(File.read('spec/support/device_data/data_request.json')) }
    let(:example_device_names) { ['ZWave', '_Scene Controller', 'Thermostat', 'Caddx NX584 Security System',
                                  'Outdoor Switch', '_GE Advanced Remote', 'Serial_Portlist_2146893057',
                                  'ftdi_sio', 'Partition 1', 'Zone 1', 'Generic IP Camera', 'On/Off Outlet',
                                  '_Home Energy Monitor', '_Home Energy Monitor Clamp 1',
                                  '_Home Energy Monitor Clamp 2', 'Ergy'] }

    let(:example_categories) { [Category.new(nil), Category.new(15), Category.new(2),
                                 Category.new(6), Category.new(7), Category.new(4),
                                 Category.new(5)] }

    let(:example_rooms) { [Room.new(1), Room.new(2)] }

    describe :initialize do
      context 'when vera unit is available' do
        it 'should respond' do
          VCR.use_cassette('data_request') do
            expect(mios.attributes.length).to eql 29
          end
        end
      end

      context 'when vera unit is not available' do
        it 'should throw an exception' do
          VCR.use_cassette('data_request_failure') do
            expect { mios.attributes }.to raise_exception 'Device not available'
          end
        end
      end
    end

    describe :refresh! do
      context 'when vera unit is available' do
        it 'should refresh all the devices' do
          VCR.use_cassette('data_request', allow_playback_repeats: true) do
            # TODO: need to change something in the devices and verify that it
            # returns back to original value
            mios.refresh!
            expect(mios.devices.length).to eql 16
          end
        end

        it 'should refresh the vera attributes' do
          VCR.use_cassette('data_request', allow_playback_repeats: true) do
            # TODO: need to change something in the attributes and verify that it
            # returns back to original value
            mios.refresh!
            expect(mios.attributes.length).to eql 29
          end
        end
      end
    end

    describe :categories do
      it 'should return an array of categories' do
        VCR.use_cassette('data_request') do
          expect(mios.categories.to_s).to eql example_categories.to_s
        end
      end
    end

    describe :attributes do
      it 'should return an array of attributes' do
        VCR.use_cassette('data_request') do
          expect(mios.attributes.length).to eql 29
          expect(mios.attributes['model']).to eql 'MiCasaVerde VeraLite'
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

    describe :devices_for do
      it 'should return an array of devices with a given category' do
        VCR.use_cassette('data_request') do
          expect(mios.devices_for_label('Lights')).to be_an(Array)
          expect(mios.devices_for_label('Lights').length).to eql 2
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

    describe :rooms do
      it 'should return a list of rooms' do
        VCR.use_cassette('data_request') do
          expect(mios.rooms.to_s).to eql(example_rooms.to_s)
        end
      end
    end

    describe :inspect do
      it 'should return the correct string' do
        VCR.use_cassette('data_request') do
          expect(mios.inspect).to include "0x#{'%x' % (mios.object_id << 1)}"
          expect(mios.inspect).to include mios.attributes.inspect
        end
      end
    end

    describe :method_missing do
      it 'should return values from the attributes when asked' do
        VCR.use_cassette('data_request') do
          expect(mios.model).to eql 'MiCasaVerde VeraLite'
        end
      end

      it 'should throw method not found error if not found in attributes' do
        VCR.use_cassette('data_request') do
          expect { mios.foo }.to raise_exception
        end
      end
    end
  end
end
