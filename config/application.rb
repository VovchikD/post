# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Postapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq

    Sidekiq.configure_server do |config|
      config.redis = { url: 'redis://localhost:6379/0' }
    end

    Sidekiq.configure_client do |config|
      config.redis = { url: 'redis://localhost:6379/0' }
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

module YourCoolApp
  class Application < Rails::Application
    config.generators.after_generate do |files|
      parsable_files = files.filter { |file| file.end_with?('.rb') }
      unless parsable_files.empty?
        system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
      end
    end
  end
end
