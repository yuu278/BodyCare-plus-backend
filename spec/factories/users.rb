FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "test_user@example.com" }
    password { "password123" }
  end
end
