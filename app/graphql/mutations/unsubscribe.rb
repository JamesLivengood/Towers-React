module Mutations
    class Unsubscribe < BaseMutation
      # arguments passed to the `resolved` method
      argument :id, ID, required: true
      argument :unsubscribe_key, String, required: true
  
      # return type from the mutation
      type Types::ContactType
  
      def resolve(id: nil, unsubscribe_key: nil)
        c = Contact.find(id)
        if c.unsubscribe_key == unsubscribe_key
            Contacts::Unsubscribe.run(c)
            c.reload
        else
            raise GraphQL::ExecutionError, "Invalid contact / unsubscribe key combo" 
        end
      end
    end
end