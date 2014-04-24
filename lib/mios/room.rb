module MiOS
  class Room
    attr_accessor :id, :name
    @@rooms = {}

    def initialize(id)
      @id = id
      @name = @@rooms[id]
    end

    def inspect
      "#{id}: #{name}"
    end

    def to_s
      name
    end

    def self.rooms=(rooms)
      @@rooms = rooms
    end

    def self.rooms
      @@rooms
    end

    def self.all
      @@rooms.each_with_object([]) { |(id, name), result| result << new(id) }
    end

  end
end
