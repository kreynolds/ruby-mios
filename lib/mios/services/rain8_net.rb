module MiOS
  module Services
    module Rain8Net1
      def self.extended(base)
        base.instance_variable_set("@rain8net_urn", "urn:wgldesigns-com:serviceId:Rain8Net:1")
        base.instance_variable_set("@hadevice_urn", "urn:micasaverde-com:serviceId:HaDevice1")
      end

      def comm_failure?
        boolean_for(@hadevice_urn, 'CommFailure')
      end

      def poll
        value_for(@hadevice_urn, "Poll")
      end

      def last_state
        value_for(@hadevice_urn, "State")
      end
    end
  end
end