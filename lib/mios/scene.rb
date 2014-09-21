module MiOS
  class Scene
    attr_reader :id, :name

    def initialize(interface, id, name)
      @interface = interface
      @id = id.to_i
      @name = name
    end

    def to_s
      name
    end

    def run
      response = Action.new(@interface,
        'urn:micasaverde-com:serviceId:HomeAutomationGateway1',
        'RunScene', 'SceneNum' => @id).take
      response.values.first.values.first
    end
  end
end
