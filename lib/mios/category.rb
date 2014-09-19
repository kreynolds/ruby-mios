module MiOS
  class Category
    attr_reader :label, :ids

    def initialize(label, ids)
      @label = label
      @ids = ids
    end

    def to_s
      label
    end
  end
end
