module MiOS
  module Services
    module HVACUserOperatingMode1
      def self.extended(base)
        base.instance_variable_set("@hvac_user_operating_mode1_urn", "urn:upnp-org:serviceId:HVAC_UserOperatingMode1")
      end

      def mode
        value_for(@hvac_user_operating_mode1_urn, 'ModeStatus')
      end
    end
  end
end