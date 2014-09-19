require 'spec_helper'

module MiOS
  describe Room do
    before do
      @room = Room.new(2, 'Living Room')
      Room.new(1, 'Kitchen')
      Room.new(3, 'Bathroom')
    end

    describe :initialize do
      it 'should return a Room object' do
        expect(@room).to be_a(Room)
        expect(@room.name).to eql 'Living Room'
        expect(@room.id).to eql 2
      end
    end

    describe :to_s do
      it 'should return the correct string' do
        expect(@room.to_s).to eql 'Living Room'
      end
    end

  end
end
