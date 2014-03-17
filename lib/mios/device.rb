module MiOS
  class Device
    attr_reader :attributes, :client, :base_uri

    def initialize(client, base_uri, data)
      @client, @base_uri = client, base_uri
      parse(data)
    end

    def inspect
      "#<MiOS::Device:0x#{'%x' % (self.object_id << 1)} name=#{@attributes['name']}>"
    end

    def method_missing(method, *args)
      if @attributes.has_key?(method.to_s)
        @attributes[method.to_s]
      else
        super
      end
    end

    def reload
      parse(MultiJson.load(@client.get("#{@base_uri}/data_request", {:id => 'status', :DeviceNum => attributes['id'], :output_format => :json}).content)["Device_Num_#{attributes['id']}"], true)
      
      self
    end
    
    private
    
    def set(urn, action, params, async=false, &block)
      MiOS::Action.new(self, urn, action, params).take(async, &block)
    end
    
    def timestamp_for(urn, key)
      Time.at integer_for(urn, key)
    end
    
    def boolean_for(urn, key)
      integer_for(urn, key) == 1
    end
    
    def integer_for(urn, key)
      value_for(urn, key).to_i
    end

    def float_for(urn, key)
      value_for(urn, key).to_f
    end

    def time_for(urn, key)
      Time.at(value_for(urn, key).to_i)
    end

    def value_for(urn, key)
      @states.each do |state_hash|
        if state_hash['service'] == urn
          if state_hash['variable'] == key
            return state_hash['value']
          end
        end
      end
      
      nil
    end
    
    def parse(data, skip_attributes=false)

      @attributes = Hash[
        data.select { |k, v|
          !data[k].kind_of?(Hash) and !data[k].kind_of?(Array)
        }.to_a
      ] unless skip_attributes     
      @states = data['states']
      @states.map { |state|
        state['service'].split(":").last
      }.uniq.each { |service|
        service.gsub!(/[^a-zA-Z0-9]/, '')
        if MiOS::Services.const_defined?(service)
          extend MiOS::Services.const_get(service)
        else
          $stderr.puts "WARNING: #{service} not yet supported"
        end
      }
      
      true
    end
  end
end