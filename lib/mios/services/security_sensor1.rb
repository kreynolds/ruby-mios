module MiOS
  module Services
    module SecuritySensor1

      URN = 'urn:micasaverde-com:serviceId:SecuritySensor1'

      def tripped?
        value_for URN, 'Tripped', as: Boolean
      end

      def armed?
        value_for URN, 'Armed', as: Boolean
      end

      def disarmed?
        !armed?
      end

      def lasttrip
        value_for URN, 'LastTrip', as: Time
      end

      def arm!(async=false, &block)
        set(URN, 'SetArmed', { "newArmedValue" => 1 }, async, &block)
      end

      def disarm!(async=false, &block)
        set(URN, 'SetArmed', { "newArmedValue" => 0 }, async, &block)
      end
    end
  end
end