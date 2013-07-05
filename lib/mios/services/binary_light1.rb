module MiOS
  module Services
    module BinaryLight
      def self.extended(base)
        base.instance_variable_set("@switchpower1_urn", "urn:schemas-upnp-org:device:BinaryLight:1")
      end

      def on?
        boolean_for(@switchpower1_urn, 'Status')
      end
      
      def off?
        !on?
      end
      
      def on!(async=false, &block)
        set(@switchpower1_urn, "SetTarget", {"newTargetValue" => 1}, async, &block)
      end

      def off!(async=false, &block)
        set(@switchpower1_urn, "SetTarget", {"newTargetValue" => 0}, async, &block)
      end
    end
  end
end