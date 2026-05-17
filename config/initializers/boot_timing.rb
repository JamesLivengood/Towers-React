if Rails.env.production?
  BOOT_START = defined?($boot_env_start) ? $boot_env_start : Process.clock_gettime(Process::CLOCK_MONOTONIC)

  ActiveSupport::Notifications.subscribe("load_config_initializer.railties") do |name, start, finish, id, payload|
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - BOOT_START
    duration = finish - start
    Rails.logger.info "BOOT_TIMING [#{elapsed.round(2)}s] #{payload[:initializer]} (#{duration.round(3)}s)" if duration > 0.5
  end

  ActiveSupport::Notifications.subscribe("railties.initialization") do |name, start, finish, id, payload|
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - BOOT_START
    duration = finish - start
    Rails.logger.info "BOOT_TIMING railtie [#{elapsed.round(2)}s] #{payload[:initializer_name] || name} (#{duration.round(3)}s)" if duration > 0.5
  end

  Rails.application.config.after_initialize do
    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - BOOT_START
    Rails.logger.info "BOOT_TIMING after_initialize complete at #{elapsed.round(2)}s"
  end
end
