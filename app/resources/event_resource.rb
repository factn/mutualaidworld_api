class EventResource < JSONAPI::Resource
  attributes :description, :location_name, :created_at, :updated_at

  has_many :scenarios

  filters :description
end
