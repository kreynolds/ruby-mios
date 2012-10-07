class MiOS::Device::WindowCovering < MiOS::Device::Generic
  ServiceId = "urn:upnp-org:serviceId:WindowCovering1"

  def up!(async=false, &block)
    set("Up", async, &block)
  end

  def down!(async=false, &block)
    set("Down", async, &block)
  end

  def stop!(async=false, &block)
    set("Stop", async, &block)
  end

  # This device has no state associated with it apparently (nothing to test with)
  def reload
    self
  end

  private
  
  def set(val, async=false, &block)
    MiOS::Device::Action.new(self, ServiceId, val).take(async, &block)
  end
end