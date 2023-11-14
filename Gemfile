# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'bootsnap', require: false
gem 'devise', '~> 4.9'
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'pry-byebug'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.8'
gem 'rubocop', require: false
gem 'rubocop-rails', require: false
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'letter_opener', '~> 1.8.1'
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails', '~> 6.0.0'
  gem 'rubocop-performance'
  gem 'simplecov', require: false
  gem 'slim_lint', '~> 0.24.0'
  gem 'slim-rails', '~> 3.6'
  gem 'tailwindcss-rails', '~> 2.0'
end
group :development do
  gem 'web-console'
end
group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
