FactoryBot.define do
  factory :user do
    firstname "John"
    lastname  "Doe"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "passWORD"
  end
end
