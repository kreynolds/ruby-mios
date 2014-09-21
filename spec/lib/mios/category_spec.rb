require 'spec_helper'

module MiOS
  describe Category do
    before do
      @category = Category.new('Sensors', [4, 12, 16, 17, 18])
    end

    describe :to_s do
      it 'should return the correct string' do
        expect(@category.to_s).to eql 'Sensors'
      end
    end
  end
end
