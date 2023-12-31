# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'factory_bot_rails'
require 'simplecov'
require 'capybara/rspec'
require 'selenium-webdriver'
SimpleCov.start do
  add_filter '/config/application.rb'
end
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new app, browser: :chrome,
                                      options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu])
end

Capybara.javascript_driver = :chrome
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec/fixtures').to_s
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :system
  config.include FactoryBot::Syntax::Methods
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
end
