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
    street_address "15 Foobar Street, Suburbsville"
    city_state "Citytown"
  end
end
