if Rails.env.production?
  Rails.application.config.after_initialize do
    Thread.new do
      attempt = 0
      begin
        ActiveRecord::Migration.check_all_pending!
      rescue ActiveRecord::PendingMigrationError
        begin
          ActiveRecord::MigrationContext.new(Rails.root.join("db/migrate").to_s).migrate
          Rails.logger.info "Migrations complete"
        rescue => e
          attempt += 1
          if attempt < 30
            sleep 5
            retry
          end
          Rails.logger.error "Migration failed after #{attempt} attempts: #{e.message}"
        end
      rescue => e
        Rails.logger.error "Migration check failed: #{e.message}"
      end
    end
  end
end
