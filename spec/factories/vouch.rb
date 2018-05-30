FactoryBot.define do
  factory :vouch do
    association(:verifier, factory: :user)
    scenario
  end
end
