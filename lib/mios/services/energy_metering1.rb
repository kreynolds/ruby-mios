module MiOS
  module Services
    module EnergyMetering1
      def self.extended(base)
        base.instance_variable_set("@energymetering1_urn", "urn:micasaverde-com:serviceId:EnergyMetering1")
      end

      def watts
        integer_for(@energymetering1_urn, 'Watts')
      end

      def kWh
        float_for(@energymetering1_urn, 'KWH')
      end

      def last_reading_at
        time_for(@energymetering1_urn, "KWHReading")
      end
    end
  end
end
