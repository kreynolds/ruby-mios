# NOTE: Currently untested with a real humidity sensor
class MiOS::Device::HumiditySensor < MiOS::Device::Generic
  ServiceId = "urn:micasaverde-com:serviceId:HumiditySensor1"

  def humidity
    @attributes['humidity'].to_i
  end
  alias_method :level, :humidity
  
  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      if h["service"] == ServiceId and h["variable"] == "CurrentLevel"
        @attributes['humidity'] = h["value"]
        break
      end
    end
    
    self
  end
end