FactoryBot.define do
  factory :user do
    firstname "John"
    lastname  "Doe"
    sequence(:email) { |n| "user#{n}@example.com" }
    password "passWORD"
    longitude "321"
    latitude "123"
    default_total_session_donation "100"
    default_swipe_donation "5"
  end
end
