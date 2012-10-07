module MiOS
  module Services
    module GenericSensor1
      def self.extended(base)
        base.instance_variable_set("@genericsensor1_urn", "urn:micasaverde-com:serviceId:GenericSensor1")
      end
    end
  end
end