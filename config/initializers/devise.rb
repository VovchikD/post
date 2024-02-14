# frozen_string_literal: true

require 'omniauth-facebook'

Devise.setup do |config|
  config.sign_out_via = :get
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_secret_key!
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 30.minutes.to_i
  end

  config.omniauth :google_oauth2,
                  Rails.application.credentials.dig(:google, :client_id),
                  Rails.application.credentials.dig(:google, :client_secret),
                  {
                    name: 'google',
                    access_type: 'offline',
                    image_aspect_ratio: 'square',
                    scope: 'userinfo.email, userinfo.profile'
                  }

  config.omniauth :facebook,
                  Rails.application.credentials.dig(:facebook, :app_id),
                  Rails.application.credentials.dig(:facebook, :app_secret),
                  {
                    name: 'facebook_oauth2',
                    scope: 'public_profile, email',
                    auth_type: 'reauthenticate',
                    provider_ignores_state: true
                  }
end
OmniAuth.config.silence_get_warning = true
