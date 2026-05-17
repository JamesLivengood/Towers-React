require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# dartsass-sprockets loads the Dart Sass binary (~1s on cold start).
# We only need it during asset compilation, not at server runtime.
# SECRET_KEY_BASE_DUMMY is set only during Docker build for assets:precompile.
require 'dartsass-sprockets' if ENV['SECRET_KEY_BASE_DUMMY'] || !ENV['RAILS_ENV'] || ENV['RAILS_ENV'] == 'development' || ENV['RAILS_ENV'] == 'test'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thenetwork
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.hosts << "usa-tower-map.herokuapp.com"
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3000', 'https://towers-n-transmitters.herokuapp.com/', 'usa-tower-map.herokuapp.com' #replace this url with that of your own heroku client app
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end
end
