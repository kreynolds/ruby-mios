class MiOS::Device::TemperatureSensor < MiOS::Device::Generic
  ServiceId = "urn:upnp-org:serviceId:TemperatureSensor1"

  def temperature
    @attributes['temperature'].to_i
  end

  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      if h["service"] == ServiceId and h["variable"] == "CurrentTemperature"
        @attributes['temperature'] = h["value"]
        break
      end
    end
    
    self
  end
end