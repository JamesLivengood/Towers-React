module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end

    field :all_contacts, [ContactType], null: false,
      description: "All Contacts"
    def all_contacts
      Contact.all
    end

    # field :contact, ContactType, null: true do
    #   argument :id, ID, required: true
    # end

    # def contact(id:)
    #   Contact.find(id)
    # end

    field :unsubscribe_contact, ContactType, null: true do
      argument :id, ID, required: true
      argument :unsubscribe_key, String, required: true
    end

    def unsubscribe_contact(id:, unsubscribe_key:)
      Contact.where(id: id, unsubscribe_key: unsubscribe_key).first
    end
  end
end
