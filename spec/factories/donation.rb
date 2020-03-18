FactoryBot.define do
  factory :donation do
    association(:donator, factory: :user)
    association(:scenario, factory: :scenario)
    amount "50"
  end
end
