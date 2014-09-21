module MiOS
  module Services
    module HaDevice1

      URN = 'urn:micasaverde-com:serviceId:HaDevice1'

      def auto_configure
        value_for(URN, 'AutoConfigure', as: Boolean)
      end

      def battery_date
        value_for(URN, 'BatteryDate', as: Time)
      end

      def battery_level
        value_for(URN, 'BatteryLevel', as: Integer)
      end

      def first_configured
        value_for(URN, 'FirstConfigured', as: Time)
      end

      def last_update
        value_for(URN, 'LastUpdate', as: Time)
      end
    end
  end
end