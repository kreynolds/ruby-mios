class MiOS::Device::LightSensor < MiOS::Device::Generic
  ServiceId = "urn:upnp-org:serviceId:LightSensor1"

  def light
    @attributes['light'].to_i
  end
  alias_method :level, :light
  
  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      if h["service"] == ServiceId and h["variable"] == "CurrentLevel"
        @attributes['light'] = h["value"]
        break
      end
    end
    
    self
  end
end