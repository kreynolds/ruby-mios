module MiOS
  class Device
    attr_reader :interface, :category

    def initialize(interface, status_info)
      @interface = interface
      @status_info = status_info
      initialize_services!
    end

    def method_missing(method, *args)
      attributes[method.to_s] || super
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

    def category
      @category ||= @interface.categories.find_by_id(category_num)
    end

    def room
      @room ||=  @interface.rooms.find { |r| r.id == attributes['room'].to_i }
    end

  private

    def category_num
      attributes['category_num'] || 0
    end

    def set(urn, action, params, async = false, &block)
      params.merge!('DeviceNum' => id)
      Action.new(interface, urn, action, params).take(async) do
        yield reload if block_given?
      end
    end

    def value_for(urn, key, type = { as: nil })
      states.each do |state|
        if state['service'] == urn
          if state['variable'] == key
            return MiOS.cast(state['value'], type[:as])
          end
        end
      end
      nil
    end

    def services
      states.map { |state|
        state['service'].split(':').last.gsub(/[^a-zA-Z0-9]/, '')
      }.uniq
    end

    def initialize_services!
      services.each do |service|
        if MiOS::Services.const_defined?(service)
          extend MiOS::Services.const_get(service)
        else
          $stderr.puts "WARNING: #{service} not yet supported"
        end
      end
      nil
    end

  end
end
