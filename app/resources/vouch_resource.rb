class VouchResource < JSONAPI::Resource
  attributes :image, :imagethumb, :scenario, :description, :rating, :created_at, :updated_at

  has_one :scenario
  has_one :verifier

  filters :scenario, :description, :rating, :created_at, :updated_at

  def imagethumb
    @model.image.url(:thumb)
  end
end
