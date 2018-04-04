class EventResource < JSONAPI::Resource
  attributes :description, :location_name

  has_many :scenarios

  filters :description
end
