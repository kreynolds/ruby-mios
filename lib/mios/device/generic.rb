module MiOS
  module Device
    Categories = {
      0 => "Generic",
      1 => "Interface",
      2 => "DimmableLight",
      3 => "Switch",
      4 => "SecuritySensor",
      5 => "HVAC",
      6 => "Camera",
      7 => "DoorLock",
      8 => "WindowCov",
      9 => "RemoteControl",
      10 => "IRTX",
      11 => "GenericIO",
      12 => "GenericSensor",
      13 => "SerialPort",
      14 => "SceneController",
      15 => "AV",
      16 => "HumiditySensor",
      17 => "TemperatureSensor",
      18 => "LightSensor",
      19 => "ZWaveInt",
      20 => "InsteonInt",
      21 => "PowerMeter",
      22 => "AlarmPanel",
      23 => "AlarmPartition"
    }

    class Generic
      include HTTParty
      format :json

      attr_reader :interface, :attributes

      def initialize(interface, attributes)
        @interface, @attributes = interface, attributes
      end

      def method_missing(method, *args)
        if @attributes.has_key?(method.to_s)
          @attributes[method.to_s]
        else
          super
        end
      end

      def to_s
        name
      end

      def category
        Categories[@attributes['category']]
      end
  
      def inspect
        "#<#{self.class.superclass}:0x#{'%x' % (self.object_id << 1)} @attributes=#{@attributes}>"
      end
      
      def refresh!
        self.class.get "/data_request?id=status&output_format=json&DeviceNum=#{id}"
      end
    end
  end
end