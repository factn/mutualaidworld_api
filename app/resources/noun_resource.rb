class NounResource < JSONAPI::Resource
  attributes :description

  has_many :scenarios

  filters :description
end
