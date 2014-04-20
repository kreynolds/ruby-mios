module MiOS
  module Services
    module Camera1

      URN = 'urn:micasaverde-com:serviceId:Camera1'

      def url
        value_for(URN, 'URL')
      end

      def full_url
        "http://#{self.ip}/#{url}"
      end
    end
  end
end