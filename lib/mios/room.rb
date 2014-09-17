module MiOS
  class Room
    attr_accessor :id, :name
    @@rooms = {}

    def initialize(id, name)
      @id = id.to_i
      @name = name
      @@rooms[@id] = self
    end

    def inspect
      "#{id}: #{name}"
    end

    def to_s
      name
    end

    def self.all
      @@rooms
    end

  end
end
