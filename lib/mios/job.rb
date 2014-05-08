require 'timeout'

module MiOS
  module Error
    class JobNonexistent < StandardError; end
    class JobError < StandardError; end
    class JobAborted < StandardError; end
    class JobRequeue < StandardError; end
    class JobTimeout < StandardError; end
  end

  class Job
    STATUS = {
      -1 => 'Nonexistent',
      0 => 'Waiting',
      1 => 'In progress',
      2 => 'Error',
      3 => 'Aborted',
      4 => 'Completed',
      5 => 'Waiting for callback',
      6 => 'Requeue',
      7 => 'In progress with pending data'
    }

    STATUS.each do |status_id, method_name|
      define_method("#{method_name.downcase.gsub(' ', '_')}?") do
        status == status_id
      end
    end

    attr_reader :id

    def initialize(interface, id, async = false, &block)
      @interface, @id = interface, id
      reload_status!

      if block_given?
        if async
          Thread.new do
            when_complete(&block)
          end
        else
          when_complete(&block)
        end
      end
    end

    def when_complete(&block)
      raise Error::JobTimeout if nonexistent?
      Timeout::timeout(20) do
        sleep_interval = 0.25

        # If the job is still processing, wait a bit and try again
        while waiting? || in_progress? || waiting_for_callback? || in_progress_with_pending_data? do
          sleep(sleep_interval += 0.25)
          reload_status!
        end
        raise Error::JobError if error?
        raise Error::JobAborted if aborted?
        raise Error::JobRequeue if requeue?
      end
      yield
    rescue Timeout::Error
      $stderr.puts 'Timed out waiting for job status to become complete'
      raise Error::JobTimeout
    end

    def status
      @status || reload_status!
    end

    def reload_status!
      @status = @interface.job_status(@id)
    end
  end
end
