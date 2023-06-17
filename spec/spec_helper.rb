require "factory_bot_rails"
require "bundler/setup"
Bundler.setup

module JsonHelpers
  def json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include JsonHelpers, type: :request

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
