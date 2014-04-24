module MiOS
  class Category
    attr_accessor :label, :ids
    @@filters = []

    def initialize(id)
      if id.nil?
        @label = 'All'
        @ids = []
      elsif id.kind_of?(Integer)
        load_for_id(id)
      else
        load_for_label(id)
      end
    end

    def self.filters=(filters)
      @@filters = filters
    end

    def self.all
      @@filters.map do |filter|
        category_nums = category_nums_for(filter)
        new category_nums.first
      end
    end

    def inspect
      "#{label}: #{ids}"
    end

    def to_s
      inspect
    end

  private

    def self.label_for(filter)
      filter['Label']['text']
    end

    def self.category_nums_for(filter)
      filter['categories'].map {|cat_num| cat_num.to_i }
    end

    def load_for_id(id)
      filter = @@filters.select { |f| self.class.category_nums_for(f).include? id }
      unless filter.empty?
        @label = self.class.label_for filter.first
        @ids = self.class.category_nums_for filter.first
      end
    end

    def load_for_label(label)
      filter = @@filters.select { |f| self.class.label_for(f) == label }
      unless filter.empty?
        @label = self.class.label_for filter.first
        @ids = self.class.category_nums_for filter.first
      end
    end
  end
end
