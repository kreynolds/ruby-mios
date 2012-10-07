module MiOS
  module Services
    module TemperatureSensor1
      def self.extended(base)
        base.instance_variable_set("@temperaturesensor1_urn", "urn:upnp-org:serviceId:TemperatureSensor1")
      end

      def temperature
        integer_for(@temperaturesensor1_urn, 'CurrentTemperature')
      end
    end
  end
end
