module MiOS
  class Device
    attr_reader :interface

    def initialize(interface, status_info)
      @interface = interface
      @status_info = status_info
      initialize_services
    end

    def inspect
      "#<MiOS::Device:0x#{'%x' % (object_id << 1)} name=#{name}>"
    end

    def method_missing(method, *args)
      if attributes.has_key?(method.to_s)
        attributes[method.to_s]
      else
        super
      end
    end

    def reload
      @status_info = @interface.device_status(id)
      self
    end

    def attributes
      @attributes ||= @status_info.select do |key, val|
        !val.kind_of?(Hash) && !val.kind_of?(Array)
      end
    end

    def states
      @status_info['states']
    end

  private

    def set(urn, action, params, async = false, &block)
      MiOS::Action.new(self, urn, action, params).take(async, &block)
    end

    def value_for(urn, key, type = { as: nil })
      states.each do |state|
        if state['service'] == urn
          if state['variable'] == key
            return MiOS.cast(state['value'], type[:as])
          end
        end
      end
    end

    def services
      states.map { |state|
        state['service'].split(':').last.gsub(/[^a-zA-Z0-9]/, '')
      }.uniq
    end

    def initialize_services
      services.each do |service|
        if MiOS::Services.const_defined?(service)
          extend MiOS::Services.const_get(service)
        else
          $stderr.puts "WARNING: #{service} not yet supported"
        end
      end
    end

  end
end