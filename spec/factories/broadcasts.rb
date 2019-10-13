FactoryBot.define do
    factory :broadcast do
        tags { ['tag1', 'tag2', 'tag3'] }
        send_at { DateTime.current + 1.day }
        markdown_body do
'Hey {first_name},

How you doing?'
        end
        subject { Faker::Lorem.sentence }
    end
end