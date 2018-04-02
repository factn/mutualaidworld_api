class ProofResource < JSONAPI::Resource
  attributes :image, :imagethumb, :scenario

  has_one :scenario

  filters :scenario

  def imagethumb
    @model.image.url(:thumb)
  end
end
