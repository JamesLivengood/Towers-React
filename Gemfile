source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.6'

gem 'rails', '~> 7.2.0'
gem 'json', '>= 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 6.0'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'vite_rails'

gem 'rack-cors', require: 'rack/cors'
gem 'redis', '~> 4.1'
gem 'sidekiq'
gem 'jbuilder', '~> 2.7'
gem 'dartsass-sprockets'

gem 'graphql'
gem 'addressable'
gem 'google-api-client'
gem 'kramdown', require: 'kramdown'
gem 'liquid'
gem 'csv'
gem 'browser'
gem 'geocoder'
gem 'zester'
gem 'zillow4r'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 6.0'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'graphiql-rails'
  gem 'pry-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'brakeman', require: false
  gem 'simplecov', require: false
  gem 'minitest'
  gem 'minitest-rails'
  gem 'selenium-webdriver'
  gem 'capybara-chrome'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
