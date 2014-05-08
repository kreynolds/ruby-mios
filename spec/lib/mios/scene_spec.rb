require 'spec_helper'

module MiOS
  describe Scene do

    before do
      VCR.use_cassette('data_request') do
        @mios = MiOS::Interface.new('http://192.168.50.21:3480')
      end
      @scene = @mios.scenes[5]
    end

    describe :run do
      it 'should run the scene' do
        VCR.use_cassette('run_scene') do
          expect(@scene.run).to eql('OK')
        end
      end
    end

    describe :inspect do
      it 'should return the correct string' do
        expect(@scene.inspect).to eql '5: Entering Home'
      end
    end

    describe :to_s do
      it 'should return the correct string' do
        expect(@scene.to_s).to eql 'Entering Home'
      end
    end

    describe :all do
      it 'should return the correct number of rooms' do
        expect(Scene.all.count).to eql 4
      end
    end
  end
end
