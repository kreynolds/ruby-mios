class MiOS::Device::DoorLock < MiOS::Device::Generic
  ServiceId = "urn:micasaverde-com:serviceId:DoorLock1"

  def locked
    @attributes['status'] == "1"
  end
  alias_method :locked?, :locked

  def unlocked; !locked; end
  alias_method :unlocked?, :unlocked

  def lock!(async=false, &block)
    MiOS::Device::Action.new(self, ServiceId, "SetTarget", {"newTargetValue" => 1}).take(async, &block)
  end

  def unlock!(async=false, &block)
    MiOS::Device::Action.new(self, ServiceId, "SetTarget", {"newTargetValue" => 0}).take(async, &block)
  end
  
  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      if h["service"] == ServiceId and h["variable"] == "Status"
        @attributes['status'] = h["value"]
        break
      end
    end
    
    self
  end
end