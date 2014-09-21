module MiOS
  module Services
    module EnergyMetering1

      URN = 'urn:micasaverde-com:serviceId:EnergyMetering1'

      def watts
        value_for URN, 'Watts', as: Integer
      end

      def kWh
        value_for URN, 'KWH', as: Float
      end

      def last_reading_at
        value_for URN, 'KWHReading', as: Time
      end
    end
  end
end
