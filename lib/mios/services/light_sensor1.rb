module MiOS
  module Services
    module LightSensor1
      def self.extended(base)
        base.instance_variable_set("@lightsensor1_urn", "urn:micasaverde-com:serviceId:LightSensor1")
      end

      def level
        @states.each do |state_hash|
          if state_hash['service'] == @lightsensor1_urn
            if state_hash['variable'] == "CurrentLevel"
              return state_hash['value'].to_i
            end
          end
        end
        
        return nil
      end
    end
  end
end
