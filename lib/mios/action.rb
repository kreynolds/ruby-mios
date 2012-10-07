require 'cgi'

module MiOS
  class Action
    def initialize(device, service_id, action, parameters={})
      @device, @service_id, @action, @parameters = device, service_id, action, parameters
    end
    
    def take(async=false, &block)
      response = @device.class.get url
      # Are there ever more than one jobs from a device action?
      Job.new(@device, response.values.first['JobID'], async, &block)
    end

    def url
      url = "/data_request?output_format=json&id=action"
      url += "&DeviceNum=#{@device.id}"
      url += "&action=#{@action}"
      url += "&serviceId=#{@service_id}&"
      url += @parameters.map { |k, v|
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      }.join("&")
    end
  end
end