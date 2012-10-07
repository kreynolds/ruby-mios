# NOTE: Currently untested with a real humidity sensor
module MiOS
  module Services
    module HumiditySensor1
      def self.extended(base)
        base.instance_variable_set("@humiditysensor1_urn", "urn:upnp-org:serviceId:HumiditySensor1")
      end

      def humidity
        integer_for(@humiditysensor1_urn, 'CurrentHumidity')
      end
    end
  end
end
