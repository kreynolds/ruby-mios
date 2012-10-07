module MiOS
  module Services
    module SceneController1
      def self.extended(base)
        base.instance_variable_set("@scenecontroller1_urn", "urn:micasaverde-com:serviceId:SceneController1")
      end
    end
  end
end