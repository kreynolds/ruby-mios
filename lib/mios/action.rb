module MiOS
  class Action
    def initialize(interface, service_id, action, parameters = {})
      @interface = interface
      @service_id = service_id
      @action = action
      @parameters = parameters
    end

    def take(async = false, &block)
      response = @interface.action(@action, @service_id, @parameters)
      # Is there ever more than one job from a device action?

      if has_job?(response)
        Job.new(@interface, response.values.first['JobID'], async, &block)
      else
        yield if block_given?
      end
      response
      # { 'u:RunSceneResponse' => { 'OK' => 'OK' } }
      # { 'u:SetTargetResponse' => { 'JobID' => '2' } }
    end

  private

    def has_job?(response)
      response.values.first.include? 'JobID'
    end

  end
end
