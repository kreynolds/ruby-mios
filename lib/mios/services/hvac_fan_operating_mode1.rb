module MiOS
  module Services
    module HVACFanOperatingMode1

      URN = 'urn:upnp-org:serviceId:HVAC_FanOperatingMode1'

      def fan_mode
        value_for URN, 'Mode'
      end
    end
  end
end