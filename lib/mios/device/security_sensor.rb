class MiOS::Device::SecuritySensor < MiOS::Device::Generic
  ServiceId = "urn:micasaverde-com:serviceId:SecuritySensor"

  def armed
    @attributes['armed'].to_i == 1
  end
  alias_method :armed?, :armed
  
  def tripped
    @attributes['tripped'].to_i == 1
  end
  alias_method :tripped?, :tripped

  def last_trip
    Time.at(@attributes['lasttrip'].to_i)
  end

  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      ["armed", "tripped"].each do |var|
        if h["service"] == ServiceId and h["variable"] == var.capitalize
          @attributes[var] = h["value"]
        end
      end
    end
    
    self
  end
end