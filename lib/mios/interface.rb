module MiOS

  class Interface
    extend Forwardable

    def_delegator :@client, :device_status
    def_delegator :@client, :action
    def_delegator :@client, :job_status

    def initialize(base_uri)
      @client = Client.new(base_uri)
      Category.filters = raw_data['category_filter']
      load_rooms
    end

    def refresh!
      @raw_data, @devices, @attributes, @categories = nil
    end

    def devices
      @devices ||= load_devices
    end

    def devices_for_label(label)
      devices.select { |device| device.category.label == label }
    end

    def rooms
      Room.all
    end

    def device_names
      devices.map(&:name)
    end

    def attributes
      @attributes ||= load_attributes
    end

    def categories
      @categories ||= Category.all
    end

    def method_missing(method, *args)
      return attributes[method.to_s] if attributes.has_key?(method.to_s)
      super
    end

    def inspect
      "#<MiOS::Interface:0x#{'%x' % (object_id << 1)} uri=#{@client.base_uri} @attributes=#{attributes.inspect}>"
    end

  private

    def raw_data
      @raw_data ||= @client.data_request(id: 'user_data')
    end

    def load_attributes
      attributes = Hash[
        raw_data
          .select { |k, v| !raw_data[k].kind_of?(Hash) && !raw_data[k].kind_of?(Array) }
          .map { |k, v| [k.downcase, v] }
      ]

      # Convert some time objects
      ['loadtime', 'devicesync'].each do |attr|
        attributes[attr] = Time.at(attributes[attr].to_i)
      end

      attributes
    end

    def load_rooms
      raw_data['rooms'].each { |r| Room.rooms[r['id']] = r['name'] }
    end

    def load_devices
      raw_data['devices'].map do |device|
        Device.new(self, device)
      end
    end
  end
end
