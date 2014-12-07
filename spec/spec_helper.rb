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
  c.ignore_hosts "codeclimate.com"
end

RSpec.configure do |config|
  config.default_formatter = "doc" if config.files_to_run.one?

  config.order = :random

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.raise_errors_for_deprecations!

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

