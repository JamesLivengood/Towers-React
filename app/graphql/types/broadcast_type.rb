module Types
    class BroadcastType < BaseObject
        field :id, ID, null: false
        field :subject, String, null: true
        field :markdown_body, String, null: true
        field :send_at, GraphQL::Types::ISO8601DateTime, null: true
        field :tags, [String], null: true
    end
end