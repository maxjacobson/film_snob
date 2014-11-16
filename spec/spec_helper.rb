if ENV["BLINK_182_DRUMMER"] == "TRAVIS"
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end
require "film_snob"
require "webmock/rspec"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
end

