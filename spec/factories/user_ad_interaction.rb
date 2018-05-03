FactoryBot.define do
  factory :user_ad_interaction do
    user
    ad_type
    interaction_type
    scenario

    trait :dismissed do
      association :interaction_type, factory: [:interaction_type, :dismissed]
    end

    trait :doer do
      association :ad_type, factory: [:ad_type, :doer]
    end

    trait :donator do
      association :ad_type, factory: [:ad_type, :donator]
    end

    trait :requester do
      association :ad_type, factory: [:ad_type, :requester]
    end

    trait :verifier do
      association :ad_type, factory: [:ad_type, :verifier]
    end
  end
end
