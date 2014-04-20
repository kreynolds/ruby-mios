module MiOS
  module Services
    module TemperatureSetpoint1Cool

      URN = 'urn:upnp-org:serviceId:TemperatureSetpoint1_Cool'

      def cool_target
        value_for URN, 'CurrentSetpoint', as: Integer
      end
    end
  end
end