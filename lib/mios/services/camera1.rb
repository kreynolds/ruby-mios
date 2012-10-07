module MiOS
  module Services
    module Camera1
      def self.extended(base)
        base.instance_variable_set("@camera1_urn", "urn:micasaverde-com:serviceId:Camera1")
      end
    end
  end
end