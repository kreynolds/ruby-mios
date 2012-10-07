module MiOS
  module Services
    module WindowCovering1
      def self.extended(base)
        base.instance_variable_set("@windowcovering1_urn", "urn:upnp-org:serviceId:WindowCovering1")
      end

      def up!(async=false, &block)
        set(@windowcovering1_urn, "Up", async, &block)
      end

      def down!(async=false, &block)
        set(@windowcovering1_urn, "Down", async, &block)
      end

      def stop!(async=false, &block)
        set(@windowcovering1_urn, "Stop", async, &block)
      end
    end
  end
end