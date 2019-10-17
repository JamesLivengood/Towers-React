module Mutations
    module Broadcasts
        class CreateBroadcast < BaseMutation
            # arguments passed to the `resolved` method
            argument :markdown, String, required: true
            argument :subject, String, required: true
        
            # return type from the mutation
            type Types::BroadcastType
        
            def resolve(markdown: nil, subject: nil)
                Broadcast.create(
                    markdown_body: markdown,
                    subject: subject
                )
            end
        end
    end
end