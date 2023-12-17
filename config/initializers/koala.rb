
Koala.configure do |config|
  config.app_id = ENV['APP_ID']
  config.app_secret = ENV['APP_SECRET']
  config.app_id = ENV['GOOGLE_CLIENT_ID']
  config.app_secret = ENV['GOOGLE_CLIENT_SECRET']
end
