# NOTE: Currently untested with a real power meter
class MiOS::Device::PowerMeter < MiOS::Device::Generic
  ServiceId = "urn:micasaverde-com:serviceId:EnergyMetering1"

  def watts
    @attributes['watts'].to_i
  end
  
  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      if h["service"] == ServiceId and h["variable"] == "Watts"
        @attributes['watts'] = h["value"]
        break
      end
    end
    
    self
  end
end