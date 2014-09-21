# NOTE: Currently untested with a real humidity sensor
module MiOS
  module Services
    module HumiditySensor1

      URN = 'urn:upnp-org:serviceId:HumiditySensor1'

      def humidity
        value_for URN, 'CurrentHumidity', as: Integer
      end
    end
  end
end
