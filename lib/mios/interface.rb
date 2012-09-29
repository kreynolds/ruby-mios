module MiOS
  class Interface

    class << self
      def new(uri, *args)
        Class.new(AbstractInterface) { |klass|
          klass.base_uri(uri)
        }.new(*args)
      end
    end

    class AbstractInterface
      include HTTParty
      format :json

      attr_reader :attributes

      def initialize
        refresh!
      end

      def method_missing(method, *args)
        if @attributes.has_key?(method.to_s)
          @attributes[method.to_s]
        else
          super
        end
      end

      def inspect
        "#<MiOS::Interface:0x#{'%x' % (self.object_id << 1)} @attributes=#{@attributes.inspect}>"
      end

      def refresh!
        data = self.class.get "/data_request?id=sdata"
        @attributes = data.select { |k, v| !data[k].kind_of?(Hash) and !data[k].kind_of?(Array)}
        @attributes['loadtime'] = Time.at(@attributes['loadtime'])
        @attributes['serial_number'].strip!

        #puts data.reject { |k, v| !data[k].kind_of?(Hash) and !data[k].kind_of?(Array)}.keys.inspect
        @devices = Hash[
          data['devices'].map { |device|
            [device['id'], create_device(device)]
          }
        ]

        true
      end

      def categories
        @devices.values.map { |device|
          device.category
        }.uniq.sort
      end

      def devices; @devices.values; end
      
      def device_names; devices.map(&:name); end

      private

      def create_device(device_attrs)
        device_klass = begin
          MiOS::Device.const_get(MiOS::Device::Categories[device_attrs['category']])
        rescue NameError => e
          MiOS::Device::Generic
        end

        interface = self
        Class.new(device_klass) { |klass|
          klass.base_uri(interface.class.base_uri)
        }.new(self, device_attrs)
      end
    end
  end
end