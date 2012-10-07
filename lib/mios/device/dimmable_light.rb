# NOTE: This device is untested and probably not correct, documentation is inconsistent
class MiOS::Device::DimmableLight < MiOS::Device::Generic
  ServiceId = "urn:upnp-org:serviceId:Dimming1"

  def load_level
    @attributes['load_level'].to_i
  end
  alias_method :level, :load_level

  def load_level!(new_load_level, async=false, &block)
    new_load_level = new_load_level.to_i
    new_load_level = 100 if new_load_level > 100
    new_load_level = 0 if new_load_level < 0
    MiOS::Device::Action.new(self, ServiceId, "SetLoadLevelTarget", {"newLoadLevelTarget" => new_load_level}).take(async, &block)
  end

  # Reload the status of this device
  def reload
    self.class.get("/data_request?id=status&output_format=json&DeviceNum=#{id}")["Device_Num_#{id}"]["states"].each do |h|
      if h["service"] == ServiceId and h["variable"] == "LoadLevel"
        @attributes['load_level'] = h["value"]
        break
      end
    end
    
    self
  end
end