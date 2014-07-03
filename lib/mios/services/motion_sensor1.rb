module MiOS
  module Services
    module MotionSensor
      def self.extended(base)
        base.instance_variable_set("@securitysensor1_urn", "urn:micasaverde-com:serviceId:SecuritySensor1")
      end

      def tripped?
        boolean_for(@securitysensor1_urn, 'Tripped')
      end
      
      def armed?
        boolean_for(@securitysensor1_urn, 'Armed')
      end
      
      def disarmed?
        !armed?
      end
      
      def lasttrip
        timestamp_for(@securitysensor1_urn, 'LastTrip')
      end
      
      def arm!(async=false, &block)
        set(@securitysensor1_urn, "SetArmed", {"newArmedValue" => 1}, async, &block)
      end

      def disarm!(async=false, &block)
        set(@securitysensor1_urn, "SetArmed", {"newArmedValue" => 0}, async, &block)
      end
    end
  end
end