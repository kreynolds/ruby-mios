module MiOS
  module Services
    module EnergyMetering1
      def self.extended(base)
        base.instance_variable_set("@energymetering1_urn", "urn:upnp-org:serviceId:EnergyMetering1")
      end

      def watts
        integer_for(@energymetering1_urn, 'Watts')
      end
    end
  end
end
