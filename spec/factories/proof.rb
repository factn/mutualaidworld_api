FactoryBot.define do
  factory :proof do
    association(:verifier, factory: :user)
    scenario
  end
end
