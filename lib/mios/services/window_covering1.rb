module MiOS
  module Services
    module WindowCovering1

      URN = 'urn:upnp-org:serviceId:WindowCovering1'

      def up!(async=false, &block)
        set(URN, 'Up', async, &block)
      end

      def down!(async=false, &block)
        set(URN, 'Down', async, &block)
      end

      def stop!(async=false, &block)
        set(URN, 'Stop', async, &block)
      end
    end
  end
end