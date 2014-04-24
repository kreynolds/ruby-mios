require 'spec_helper'

module MiOS
  describe Category do
    before do
      Category.filters = MultiJson.load(File.read('spec/support/device_data/category_filter.json'))
      @category = Category.new(16)
    end

    describe :initialize do
      it 'should return a Category object' do
        expect(@category).to be_a(Category)
        expect(@category.label).to eql 'Sensors'
        expect(@category.ids).to eql [4, 12, 16, 17, 18]
      end
    end
    describe :inspect do
      it 'should return the correct string' do
        expect(@category.inspect).to eql 'Sensors: [4, 12, 16, 17, 18]'
      end
    end

    describe :all do
      it 'should return an array of all Categories' do
        expect(Category.all.count).to eql 7
      end
    end
  end
end
