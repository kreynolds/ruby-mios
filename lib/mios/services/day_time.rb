module MiOS
  module Services
    module DayTime
      def self.extended(base)
        base.instance_variable_set("@switchpower1_urn", "urn:rts-services-com:serviceId:DayTime")
      end

      def day?
        boolean_for(@switchpower1_urn, 'Status')
      end
      
      def night?
        !day?
      end
    end
  end
end