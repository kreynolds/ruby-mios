module MiOS
  module Services
    module DoorLock1
      def self.extended(base)
        base.instance_variable_set("@doorlock1_urn", "urn:micasaverde-com:serviceId:DoorLock1")
      end

      def min_pin_size
        integer_for(@doorlock1_urn, 'MinPinSize')
      end

      def max_pin_size
        integer_for(@doorlock1_urn, 'MaxPinSize')
      end

      def locked?
        boolean_for(@doorlock1_urn, 'Status')
      end

      def unlocked?
        !locked?
      end

      def pincodes
        tmp = value_for(@doorlock1_urn, 'PinCodes')
        tmp.gsub!(/^<[^>]+>/, '').split("\t")
      end
      
      def lock!(async=false, &block)
        set(@doorlock1_urn, "SetTarget", {"newTargetValue" => 1}, async, &block)
      end

      def unlock!(async=false, &block)
        set(@doorlock1_urn, "SetTarget", {"newTargetValue" => 0}, async, &block)
      end
      
      def set_pin(name, pin, index, async=false, &block)
        set(@doorlock1_urn, "SetPin", {"UserCodeName" => name, "newPin" => pin, "user" => index}, async, &block)
      end

      def clear_pin(index, async=false, &block)
        set(@doorlock1_urn, "ClearPin", {"UserCode" => index}, async, &block)
      end
    end
  end
end