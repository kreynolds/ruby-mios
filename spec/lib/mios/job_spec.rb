require 'spec_helper'

describe MiOS::Job do
  let(:job) do
    interface = double('interface', data_request: { 'status' => 1 })
    device = double('device', interface: interface)
    MiOS::Job.new(device, 1)
  end

  def stub_job_status(val)
    job.stub(:status).and_return(val)
  end

  describe 'status predicate methods' do

    it 'have been defined' do
      job.class::STATUS.each do |status_num, status_name|
        n = status_name.downcase.gsub(' ', '_') + '?'
        job.methods.should include(n.to_sym), "#{n} not defined #{ job.class }"
      end
    end
  end

  describe :when_complete do

    [[-1, MiOS::Error::JobTimeout],
    [2, MiOS::Error::JobError],
    [3, MiOS::Error::JobAborted],
    [6, MiOS::Error::JobRequeue]
    ].each do |status_num, err|
      it "raises a #{err.to_s.split('::').last} when status #{ status_num }" do
        stub_job_status(status_num)
        expect { job.when_complete }.to raise_error(err)
      end
    end
  end

  describe :status do

    it 'memoizes status instance variable' do
      job.instance_variable_set('@status', 2)
      job.stub(:reload_status!).and_return(3)
      expect(job.status).to eq 2
    end
  end

  describe :reload_status! do

    it 'sets status instance variable' do
      job.instance_variable_set('@status', nil)
      job.reload_status!
      expect(job.instance_variable_get('@status')).to eq 1
    end
  end
end
