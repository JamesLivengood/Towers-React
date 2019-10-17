module Broadcasts
    class Deliver < Operations::Base
        attr_reader :broadcast

        def initialize(**args)
            @klass = Broadcasts::Deliver
            super
        end

        def self.run(broadcast)
            new(broadcast: broadcast).perform
        end

        def perform
            broadcast.with_lock do
                return unless broadcast.sent_at.nil?
                return if broadcast.send_at.nil?
                send_to_recipients
                mark_broadcast_as_sent
            end
        end

        private

        def send_to_recipients
            recipients.find_each do |contact|
                NickoneillSesMailer.broadcast(contact.id, broadcast.id).deliver_later
            end
        end

        def mark_broadcast_as_sent
            broadcast.update!(sent_at: Time.current)
        end

        def recipients
            @recipients ||= Contact.select(:id).where("subscribed_at IS NOT NULL AND unsubscribed_at IS NULL")
        end
    end
end