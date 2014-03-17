module MiOS
  module Services
    module TemperatureSetpoint1Heat
      def self.extended(base)
        base.instance_variable_set("@temperaturesetpoint1heat_urn", "urn:upnp-org:serviceId:TemperatureSetpoint1_Heat")
      end

      def heat_target
        integer_for(@temperaturesetpoint1heat_urn, 'CurrentSetpoint')
      end
    end
  end
end