FactoryBot.define do
  factory :user_ad_interaction do
    user
    ad_type
    interaction_type
    scenario
  end
end
