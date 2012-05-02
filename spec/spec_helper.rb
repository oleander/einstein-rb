require "rspec"
require "webmock/rspec"
require "einstein"
require "vcr"
require "yaml"

RSpec.configure do |config|
  config.mock_with :rspec
  config.extend VCR::RSpec::Macros
end

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.default_cassette_options = {
    record: :new_episodes,
    serialize_with: :yaml
  }
  c.preserve_exact_body_bytes do |request|
    request.body.encoding.name == 'ASCII-8BIT' || !request.body.valid_encoding?
  end
  c.allow_http_connections_when_no_cassette = false
end