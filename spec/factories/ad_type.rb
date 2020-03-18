FactoryBot.define do
  factory :ad_type do
    description "An Ad Type"

    trait :doer do
      description "doer"
    end

    trait :donator do
      description "donator"
    end

    trait :requester do
      description "requester"
    end

    trait :verifier do
      description "verifier"
    end
  end
end
