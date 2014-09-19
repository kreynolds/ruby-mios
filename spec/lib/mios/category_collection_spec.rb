require 'spec_helper'

module MiOS
  describe CategoryCollection do
    before do
      filters = JSON.parse(File.read('spec/support/device_data/category_filter.json'))
      @category_collection = CategoryCollection.new(filters)
      @category = @category_collection.all[5]
    end

    describe :find_for_id do
      it 'should return a Category object given an id' do
        category = @category_collection.find_by_id(16)
        expect(category).to eql @category
      end
    end

    describe :find_for_label do
      it 'should return a Category object given a label' do
        category = @category_collection.find_by_label('Sensors')
        expect(category).to eql @category
      end
    end

    describe :all do
      it 'should return an array of all Categories' do
        expect(@category_collection.all.count).to eql 7
      end
    end

    describe :to_s do
      it 'should return the correct string' do
        expect(@category_collection.to_s).to_not be_empty
      end
    end
  end
end
