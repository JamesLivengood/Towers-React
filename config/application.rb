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

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
if ENV["RAILS_ENV"] == "production"
  $app_require_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  $stderr.puts "APP: starting Bundler.require at t=#{($boot_env_start ? Process.clock_gettime(Process::CLOCK_MONOTONIC) - $boot_env_start : 0).round(2)}s"

  orig_require = Kernel.instance_method(:require)
  $slow_requires = {}
  Kernel.define_method(:require) do |path|
    t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    result = orig_require.bind(self).call(path)
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
    if elapsed > 0.3
      $stderr.puts "APP SLOW REQUIRE (#{elapsed.round(2)}s): #{path}"
    end
    result
  end

  Bundler.require(*Rails.groups)

  Kernel.define_method(:require, orig_require)
  elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - $app_require_start
  $stderr.puts "APP: Bundler.require complete in #{elapsed.round(2)}s"
else
  Bundler.require(*Rails.groups)
end

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
