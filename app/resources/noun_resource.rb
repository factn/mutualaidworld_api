class NounResource < JSONAPI::Resource
  attributes :description

  has_many :scenarios
end
