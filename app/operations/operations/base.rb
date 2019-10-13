module Operations
    class Base
        def initialize(**args)
            args.each do |k, v|
                instance_variable_set("@#{k}", v) unless v.nil?
            end
            log_operation(args)
        end

        def log_operation(args, klass = nil)
            hex = SecureRandom.uuid
            Rails.logger.info("New Operation: #{@klass || klass} #{hex}")
            Rails.logger.info("Args for #{hex}: #{log_str(args)}")
        end

        private

        def log_str(args)
            args.map { |k, v| "#{k}=#{v}" }.join('&')
        end
    end
end