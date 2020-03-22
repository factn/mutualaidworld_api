FactoryBot.define do
  factory :user do
    firstname "John"
    lastname  "Doe"
    sequence(:email) { |n| "user#{n}@example.com" }
    longitude "321"
    latitude "123"
    street_address "15 Foobar Street, Suburbsville"
    city_state "Citytown"
    phone Faker::PhoneNumber.unique.cell_phone
  end
end
