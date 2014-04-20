module MiOS
  module Services
    module HVACOperatingState1

      URN = 'urn:micasaverde-com:serviceId:HVAC_OperatingState1'

      def operating_state
        value_for URN, 'ModeState'
      end
    end
  end
end