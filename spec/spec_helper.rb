require 'rubygems'
require 'rspec'
require 'vcr'
require 'pry'
require 'simplecov'
SimpleCov.start

$LOAD_PATH << "#{File.expand_path(File.dirname(__FILE__))}/../lib"
require "mios"


VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.allow_http_connections_when_no_cassette = true
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