module MiOS
  module Services
    module TemperatureSetpoint1Cool
      def self.extended(base)
        base.instance_variable_set("@temperaturesetpoint1cool_urn", "urn:upnp-org:serviceId:TemperatureSetpoint1_Cool")
      end

      def cool_target
        integer_for(@temperaturesetpoint1cool_urn, 'CurrentSetpoint')
      end
    end
  end
end