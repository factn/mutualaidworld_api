FactoryBot.define do
  factory :scenario do
    association(:requester, factory: :user)
    association(:event, factory: :event)
    association(:verb, factory: :verb)
    association(:noun, factory: :noun)

    funding_goal "50"
  end
end
