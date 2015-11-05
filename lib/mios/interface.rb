require 'forwardable'

module MiOS

  class Interface
    extend Forwardable

    def_delegator :@client, :device_status
    def_delegator :@client, :action
    def_delegator :@client, :job_status

    def initialize(base_uri)
      @client = Client.new(base_uri)
    end

    def refresh!
      @raw_data, @devices, @attributes, @categories, @rooms, @scenes = nil
    end

    def categories
      @categories ||= CategoryCollection.new(raw_data['category_filter'])
    end

    def devices
      @devices ||= raw_data['devices'].collect { |d| Device.new(self, d) }
    end

    def devices_for_label(label)
      devices.select { |device| device.category && device.category.label == label }
    end

    def rooms
      @rooms ||= raw_data['rooms'].collect { |r| Room.new(r['id'], r['name']) }
    end

    def scenes
      @scenes ||= raw_data['scenes'].collect { |s| Scene.new(self, s['id'], s['name']) }
    end

    def device_names
      devices.map(&:name)
    end

    def attributes
      @attributes ||= load_attributes
    end

    def method_missing(method, *args)
      attributes[method.to_s] || super
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
        attributes[attr] = MiOS.cast(attributes[attr], as: Time)
      end

      attributes
    end
  end
end
