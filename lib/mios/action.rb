require 'cgi'

module MiOS
  class Action
    def initialize(device, service_id, action, parameters={})
      @device, @service_id, @action, @parameters = device, service_id, action, parameters
    end

    def take(async=false, &block)
      response = @device.interface.action(url_params)
      # Are there ever more than one jobs from a device action?
      Job.new(@device, response.values.first['JobID'], async, &block)
    end

    def url_params
      {
        :id => 'action',
        :DeviceNum => @device.attributes["id"],
        :action => @action,
        :serviceId => @service_id,
      }.merge(@parameters)
    end
  end
end