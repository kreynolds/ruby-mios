module MiOS
  class Client
    attr_reader :base_uri

    def initialize(base_uri)
      @base_uri = base_uri
      @client = HTTPClient.new
    end

    def data_request(params)
      default_params = { output_format: :json }
      params = default_params.merge(params)
      response = @client.get("#{@base_uri}/data_request", params)
      return JSON.parse(response.content) if response.ok?
      fail 'Device not available'
    end

    def device_status(device_id)
      result = data_request(id: 'status', DeviceNum: device_id)
      result["Device_Num_#{device_id}"]
    end

    def action(action, service_id, params = {})
      data_request({
        id: 'action',
        action: action,
        serviceId: service_id,
      }.merge(params))
    end

    def job_status(job_id)
      data_request(id: 'jobstatus', job: job_id, plugin: 'zwave')['status']
    end
  end
end
