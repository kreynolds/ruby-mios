module MiOS
  class CategoryCollection

    def initialize(filters)
      @filters = filters
      @categories = @filters.each_with_object([]) do |filter, categories|
        categories << Category.new(label_for(filter), category_nums_for(filter))
      end
    end

    def all
      @categories
    end

    def find_by_id(id)
      @categories.find { |c| c.ids.include? id }
    end

    def find_by_label(label)
      @categories.find { |c| c.label == label }
    end

    def to_s
      @categories.to_s
    end

  private

    def label_for(filter)
      filter['Label']['text']
    end

    def category_nums_for(filter)
      filter['categories'].map {|cat_num| cat_num.to_i }
    end

  end
end
