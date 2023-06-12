ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../test/dummy/config/environment", __dir__)

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), "../")

abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

require "support/factory_bot"

Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |f| require f }

begin
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Payify::Engine.routes.url_helpers
end
