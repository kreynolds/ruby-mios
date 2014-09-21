module MiOS
  class Room
    attr_reader :id, :name

    def initialize(id, name)
      @id = id.to_i
      @name = name
    end

    def to_s
      name
    end
  end
end
