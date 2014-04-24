require 'spec_helper'

describe 'light type device control' do
  let(:mios) { MiOS::Interface.new('http://192.168.50.21:3480') }

  it 'should turn on the light' do
    VCR.use_cassette('turn_on_light') do
      mios.devices[11].on! { expect(mios.devices[11]).to be_on }
    end
  end

  it 'should turn off the light' do
    VCR.use_cassette('turn_off_light') do
      mios.devices[11].off! { expect(mios.devices[11]).to be_off }
    end
  end
end
