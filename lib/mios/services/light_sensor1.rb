module MiOS
  module Services
    module LightSensor1

      URN = 'urn:micasaverde-com:serviceId:LightSensor1'

      def level
        value_for URN, 'CurrentLevel', as: Integer
      end

    end
  end
end
