module MiOS
  module Services
    module IOSPush1
      def self.extended(base)
        base.instance_variable_set("@iospush1_urn", "urn:schemas-upnp-org:service:IOSPush:1")
      end
    end
  end
end