module MiOS
  module Services
    module Dimming1

      URN = 'urn:upnp-org:serviceId:Dimming1'

      def level
        value_for(URN, 'LoadLevelStatus', as: Integer)
      end

      def set_level!(new_level, async=false, &block)
        new_level = new_load_level.to_i
        new_level = 100 if new_load_level > 100
        new_level = 0 if new_load_level < 0
        set(URN, 'SetLoadLevelTarget', { "newLoadlevelTarget" => new_level }, async, &block)
      end
    end
  end
end