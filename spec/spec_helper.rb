require 'film_snob'
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |c|
	c.before(:each) do |spec|
		puts spec.full_description
	end
end


VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

