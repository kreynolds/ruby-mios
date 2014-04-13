module MiOS
  class Client

    def initialize(base_uri)
      @base_uri = base_uri
      @client = HTTPClient.new
    end

    def data_request(params)
      default_params = { :output_format => :json}
      params = default_params.merge(params)
      response = @client.get("#{@base_uri}/data_request", params)
      return MultiJson.load(response.content) if response.ok?
      raise 'Device not available'
    end

  end
end