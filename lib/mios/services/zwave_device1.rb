module MiOS
  module Services
    module ZWaveDevice1
      def self.extended(base)
        base.instance_variable_set("@zwavedevice1_urn", "urn:micasaverde-com:serviceId:ZWaveDevice1")
      end
    end
  end
end