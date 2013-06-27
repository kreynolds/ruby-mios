module MiOS
  module Services
    module Dimming1
      def self.extended(base)
        base.instance_variable_set("@dimming1_urn", "urn:upnp-org:serviceId:Dimming1")
      end

      def level
        integer_for(@dimming1_urn, 'LoadLevelStatus')
      end
      
      def set_level!(new_level, async=false, &block)
        new_level = new_load_level.to_i
        new_level = 100 if new_load_level > 100
        new_level = 0 if new_load_level < 0
        set(@dimming1_urn, "SetLoadLevelTarget", {"newLoadlevelTarget" => new_level}, async, &block)
      end
    end
  end
end