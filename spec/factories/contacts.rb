FactoryBot.define do
    factory :contact do
        first_name { Faker::Name.first_name }
        last_name { Faker::Name.last_name }
        # description_markdown
        primary_email { Faker::Internet.email }
        secondary_emails { [Faker::Internet.email] }
        phone { Faker::PhoneNumber.cell_phone }
        linkedin { "https://www.linkedin.com/in/#{Faker::Twitter.user[:screen_name]}" }
        twitter { Faker::Twitter.user[:screen_name] }
        instagram { "https://www.instagram.com/#{Faker::Twitter.user[:screen_name]}" }
        tags { ['tag1','tag2','tag3'] }
        # subscribed_at
        # unsubscribed_at
    end
end