module MiOS
  module Services
    module TemperatureSensor1

      URN = 'urn:upnp-org:serviceId:TemperatureSensor1'

      def temperature
        value_for URN 'CurrentTemperature', as: Integer
      end
    end
  end
end
