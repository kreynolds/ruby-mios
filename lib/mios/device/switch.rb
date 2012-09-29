class MiOS::Device::Switch < MiOS::Device::Generic
  ServiceId = "urn:upnp-org:serviceId:SwitchPower1"

  def on
    @attributes['status'] == "1"
  end
  alias_method :on?, :on

  def off; !on; end
  alias_method :off?, :off

  def on!(async=false, &block)
    MiOS::Device::Action.new(self, ServiceId, "SetTarget", {"newTargetValue" => 1}).take(async, &block)
  end

  def off!(async=false, &block)
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