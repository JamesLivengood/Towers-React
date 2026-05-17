# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
if ENV["RAILS_ENV"] == "production"
  $boot_env_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
  $stderr.puts "BOOT_ENV: starting Rails.application.initialize! at t=0"
end

Rails.application.initialize!

if ENV["RAILS_ENV"] == "production"
  elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - $boot_env_start
  $stderr.puts "BOOT_ENV: initialize! complete at #{elapsed.round(2)}s"
end
