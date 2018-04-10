class InteractionTypeResource < JSONAPI::Resource
  attributes :description

  has_many :user_ad_interactions

  filters :description
end
