module MiOS
  class Interface
    attr_reader :attributes, :base_uri

    def initialize(base_uri)
      @base_uri = base_uri
      @client = HTTPClient.new
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
      "#<MiOS::Interface:0x#{'%x' % (self.object_id << 1)} @base_uri=#{@base_uri} @attributes=#{@attributes.inspect}>"
    end

    def refresh!
      data = MultiJson.load(@client.get("#{base_uri}/data_request", {:id => "user_data", :output_format => :json}).content)
      @attributes = Hash[
        data.select { |k, v|
          !data[k].kind_of?(Hash) and !data[k].kind_of?(Array)
        }.map { |k, v|
          [k.downcase, v]
        }
      ]
      # Convert some time objects
      ['loadtime', 'devicesync'].each do |attr|
        @attributes[attr] = Time.at(@attributes[attr].to_i)
      end
      @devices = Hash[
        data['devices'].map { |device|
          [device['id'], Device.new(@client, @base_uri, device)]
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
  end
end