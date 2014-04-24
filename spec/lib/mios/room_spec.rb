require 'spec_helper'

module MiOS
  describe Room do
    before do
      Room.rooms = { 1 => 'Kitchen', 2 => 'Living Room', 3 => 'Bathroom' }
      @room = Room.new(2)
    end

    describe :initialize do
      it 'should return a Room object' do
        expect(@room).to be_a(Room)
        expect(@room.name).to eql 'Living Room'
        expect(@room.id).to eql 2
      end
    end

    describe :inspect do
      it 'should return the correct string' do
        expect(@room.inspect).to eql '2: Living Room'
      end
    end

    describe :to_s do
      it 'should return the correct string' do
        expect(@room.to_s).to eql 'Living Room'
      end
    end

    describe :all do
      it 'should return the correct number of rooms' do
        expect(Room.all.count).to eql 3
      end
    end
  end
end
