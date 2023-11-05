# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  # Група налаштувань для розробки
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  # Налаштування поштового сервера
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  configure_mailer_settings(config.action_mailer)

  # Налаштування кешування
  configure_caching_settings(config)

  # Налаштування Active Storage
  config.active_storage.service = :local

  # Налаштування бази даних та логування
  configure_database_and_logging(config)

  # Інші налаштування
  config.server_timing = true
  config.assets.quiet = true
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end
  # config.i18n.raise_on_missing_translations = true
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Розкоментуйте, якщо потрібно дозволити доступ до Action Cable з будь-якого джерела.
  # config.action_cable.disable_request_forgery_protection = true
end

def configure_mailer_settings(action_mailer)
  action_mailer.delivery_method = :letter_opener
  action_mailer.perform_deliveries = true
  action_mailer.raise_delivery_errors = false
  action_mailer.perform_caching = false
end

def configure_database_and_logging(config)
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true
end
