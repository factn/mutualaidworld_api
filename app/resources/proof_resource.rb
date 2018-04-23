class ProofResource < JSONAPI::Resource
  attributes :image, :imagethumb, :scenario, :created_at, :updated_at

  has_one :scenario
  has_one :verifier

  filters :scenario

  def imagethumb
    @model.image.url(:thumb)
  end
end
