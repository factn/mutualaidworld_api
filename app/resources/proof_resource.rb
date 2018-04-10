class ProofResource < JSONAPI::Resource
  attributes :image, :imagethumb, :scenario

  has_one :scenario
  has_one :verifier

  filters :scenario

  def imagethumb
    @model.image.url(:thumb)
  end
end
