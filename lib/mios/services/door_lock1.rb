module MiOS
  module Services
    module DoorLock1

      URN = 'urn:micasaverde-com:serviceId:DoorLock1'

      def min_pin_size
        value_for URN, 'MinPinSize', as: Integer
      end

      def max_pin_size
        value_for URN, 'MaxPinSize', as: Integer
      end

      def locked?
        value_for URN, 'Status', as: Boolean
      end

      def unlocked?
        !locked?
      end

      def pincodes
        tmp = value_for(URN, 'PinCodes')
        tmp.gsub!(/^<[^>]+>/, '').split("\t")
      end

      def lock!(async=false, &block)
        set(URN, 'SetTarget', { "newTargetValue" => 1 }, async, &block)
      end

      def unlock!(async=false, &block)
        set(URN, 'SetTarget', { "newTargetValue" => 0 }, async, &block)
      end

      def set_pin(name, pin, index, async=false, &block)
        set(URN, 'SetPin', { "UserCodeName" => name, "newPin" => pin, "user" => index }, async, &block)
      end

      def clear_pin(index, async=false, &block)
        set(URN, 'ClearPin', { "UserCode" => index }, async, &block)
      end
    end
  end
end