module Types
  class MutationType < Types::BaseObject
    field :unsubscribe, mutation: Mutations::Unsubscribe
    field :create_broadcast, mutation: Mutations::Broadcasts::CreateBroadcast
  end
end
