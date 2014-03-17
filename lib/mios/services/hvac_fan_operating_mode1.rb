module MiOS
  module Services
    module HVACFanOperatingMode1
      def self.extended(base)
        base.instance_variable_set("@hvac_fan_operating_mode1_urn", "urn:upnp-org:serviceId:HVAC_FanOperatingMode1")
      end

      def fan_mode
        value_for(@hvac_fan_operating_mode1_urn, 'Mode')
      end
    end
  end
end