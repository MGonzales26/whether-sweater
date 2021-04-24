FactoryBot.define do
  factory :user do
    email { "factory_bot_email@example.com" }
    password_digest { "1234" }
    api_key { "MyString" }
  end
end
