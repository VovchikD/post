# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch('GOOGLE_CLIENT_ID', nil), ENV.fetch('GOOGLE_CLIENT_SECRET', nil),
  {
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 200,
    provider_ignores_state: true
  }
  provider :facebook, ENV['APP_ID'], ENV['APP_SECRET'],
  {
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 200,
    provider_ignores_state: true
  }
end
OmniAuth.config.allowed_request_methods = %i[get]
