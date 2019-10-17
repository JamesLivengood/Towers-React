require 'rails_helper'

RSpec.describe Mutations::Broadcasts::CreateBroadcast, type: :request do
    before do
        host! 'network.nickoneill.com'
    end
    describe '.resolve' do
        it 'creates a broadcast' do
            broadcast = build(:broadcast)

            expect do
                post '/graphql', params: { query: query(markdown: broadcast.markdown_body, subject: broadcast.subject) }
            end.to change { Broadcast.count }.by(1)
        end

        it 'returns a broadcast' do
            broadcast = build(:broadcast)
            post '/graphql', params: { query: query(markdown: broadcast.markdown_body, subject: broadcast.subject) }
            
            json = JSON.parse(response.body)
            data = json['data']['createBroadcast']
  
            expect(data).to include(
              'id'              => be_present,
              'subject'         => broadcast.subject,
              'markdownBody'    => broadcast.markdown_body
            )
        end
    end

    def query(markdown:, subject:)
        <<~GQL
          mutation {
            createBroadcast(
                markdown: "#{markdown}"
                subject: "#{subject}"
            ) {
              id
              subject
              markdownBody
            }
          }
        GQL
    end
end