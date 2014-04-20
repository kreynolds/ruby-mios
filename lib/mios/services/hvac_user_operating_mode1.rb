module MiOS
  module Services
    module HVACUserOperatingMode1

      URN = 'urn:upnp-org:serviceId:HVAC_UserOperatingMode1'

      def mode
        value_for URN, 'ModeStatus'
      end
    end
  end
end