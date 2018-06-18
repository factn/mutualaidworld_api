FactoryBot.define do
  factory :vouch do
    association(:verifier, factory: :user)
    scenario
    rating 0.5
    description "a description"
  end
end
