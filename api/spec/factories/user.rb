FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.com" }
    sequence(:username) { |n| "testuser#{n}" }
    sequence(:name) { |n| "Test User #{n}" }
    password { "password" }
  end
end
