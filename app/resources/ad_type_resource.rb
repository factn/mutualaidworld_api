class AdTypeResource < JSONAPI::Resource
  attributes :description, :created_at, :updated_at

  has_many :user_ad_interactions

  filters :description
end
