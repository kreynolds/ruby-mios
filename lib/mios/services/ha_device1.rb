module MiOS
  module Services
    module HaDevice1
      def self.extended(base)
        base.instance_variable_set("@hadevice1_urn", "urn:micasaverde-com:serviceId:HaDevice1")
      end

      def battery_level
        integer_for(@hadevice1_urn, "BatteryLevel")
      end

      def battery_date
        timestamp_for(@hadevice1_urn, "BatteryDate")
      end
    end
  end
end