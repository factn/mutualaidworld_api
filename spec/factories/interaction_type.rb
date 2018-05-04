FactoryBot.define do
  factory :interaction_type do
    description "An Interaction Type"

    trait :dismissed do
      description "dismissed"
    end

    trait :served_to do
      description "served_to"
    end
  end
end
