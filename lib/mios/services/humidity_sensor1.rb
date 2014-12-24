# Tested with Everspring Combo Sensor
module MiOS
  module Services
    module HumiditySensor1

      URN = 'urn:micasaverde-com:serviceId:HumiditySensor1'

      def humidity
        value_for URN, 'CurrentLevel', as: Integer
      end
    end
  end
end
