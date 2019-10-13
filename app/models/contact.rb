class Contact < ApplicationRecord
    before_create :create_unsubscribe_key

    def tags=(_tags)
        if _tags.class == String
            super(_tags.split(','))
        elsif _tags.class == Array
            super(_tags)
        end
    end

    private

    def create_unsubscribe_key
        loop do
            self.unsubscribe_key = SecureRandom.hex(15)
            break unless self.class.exists?(:unsubscribe_key => unsubscribe_key)
        end
    end
end
