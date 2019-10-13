module Contacts
    class Unsubscribe < Operations::Base
        attr_reader :contact

        def initialize(**args)
            @klass = Contacts::Unsubscribe
            super
        end

        def self.run(contact)
            new(contact: contact).perform
        end

        def perform
            contact.with_lock do
                update_contact_status
            end
        end

        private

        def update_contact_status
            contact.update!(unsubscribed_at: Time.current)
        end
    end
end