module MiOS
  module Services
    module HaDevice1
      def self.extended(base)
        base.instance_variable_set("@hadevice1_urn", "urn:micasaverde-com:serviceId:HaDevice1")
      end

      def auto_configure
        boolean_for(@hadevice1_urn, "AutoConfigure")
      end

      def battery_date
        timestamp_for(@hadevice1_urn, "BatteryDate")
      end

      def battery_level
        integer_for(@hadevice1_urn, "BatteryLevel")
      end

      def first_configured
        timestamp_for(@hadevice1_urn, "FirstConfigured")
      end

      def last_update
        timestamp_for(@hadevice1_urn, "LastUpdate")
      end
    end
  end
end