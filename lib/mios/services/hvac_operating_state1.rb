module MiOS
  module Services
    module HVACOperatingState1
      def self.extended(base)
        base.instance_variable_set("@hvac_operating_state1_urn", "urn:micasaverde-com:serviceId:HVAC_OperatingState1")
      end

      def operating_state
        value_for(@hvac_operating_state1_urn, 'ModeState')
      end
    end
  end
end