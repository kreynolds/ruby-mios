require 'rubygems'
require 'rspec'
require 'vcr'
require 'pry'
require 'simplecov'
SimpleCov.start

$LOAD_PATH << "#{File.expand_path(File.dirname(__FILE__))}/../lib"
require "mios"

RSpec.configure do |config|
  config.color_enabled = true
  config.before(:each) { silence_output }
  config.after(:each) { enable_output }
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.allow_http_connections_when_no_cassette = true
end

# Redirects stderr and stdout to /dev/null.
def silence_output
  @orig_stderr = $stderr
  @orig_stdout = $stdout
  $stderr = File.new('/dev/null', 'w')
  $stdout = File.new('/dev/null', 'w')
end

# Replace stdout and stderr so anything else is output correctly.
def enable_output
  $stderr = @orig_stderr
  $stdout = @orig_stdout
end

def capture_stderr(&block)
  original_stderr = $stderr
  $stderr = fake = StringIO.new
  begin
    yield
  ensure
    $stderr = original_stderr
  end
  fake.string
end