module MiOS
  module Services
    module ZWaveNetwork1
      def self.extended(base)
        base.instance_variable_set("@zwavenetwork1_urn", "urn:micasaverde-com:serviceId:ZWaveNetwork1")
      end
    end
  end
end