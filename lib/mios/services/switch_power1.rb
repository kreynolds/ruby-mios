module MiOS
  module Services
    module SwitchPower1

      URN = 'urn:upnp-org:serviceId:SwitchPower1'

      def on?
        value_for URN, 'Status', as: Boolean
      end

      def off?
        !on?
      end

      def on!(async=false, &block)
        set(URN, 'SetTarget', { "newTargetValue" => 1 }, async, &block)
      end

      def off!(async=false, &block)
        set(URN, 'SetTarget', { "newTargetValue" => 0 }, async, &block)
      end
    end
  end
end