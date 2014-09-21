module MiOS
  module Services
    module TemperatureSetpoint1Heat

      URN = 'urn:upnp-org:serviceId:TemperatureSetpoint1_Heat'

      def heat_target
        value_for URN, 'CurrentSetpoint', as: Integer
      end
    end
  end
end