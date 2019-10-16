module Types
  class MutationType < Types::BaseObject
    field :unsubscribe, mutation: Mutations::Unsubscribe
  end
end
