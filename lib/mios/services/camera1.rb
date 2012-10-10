module MiOS
  module Services
    module Camera1
      def self.extended(base)
        base.instance_variable_set("@camera1_urn", "urn:micasaverde-com:serviceId:Camera1")
      end
      
      def url
        value_for(@camera1_urn, 'URL')
      end

      def full_url
        "http://#{self.ip}/#{url}"
      end
    end
  end
end