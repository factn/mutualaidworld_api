class VerbResource < JSONAPI::Resource
  attributes :description, :created_at, :updated_at

  has_many :scenarios

  filters :description
end
