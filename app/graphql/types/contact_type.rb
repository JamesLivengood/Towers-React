module Types
    class ContactType < BaseObject
        field :id, ID, null: false
        field :first_name, String, null: false
        field :last_name, String, null: false
        field :description_markdown, String, null: true
        field :primary_email, String, null: true
        field :secondary_emails, [String], null: true
        field :phone, String, null: true
        field :linkedin, String, null: true
        field :twitter, String, null: true
        field :instagram, String, null: true
        field :unsubscribed_at, GraphQL::Types::ISO8601DateTime, null: true
    end
end