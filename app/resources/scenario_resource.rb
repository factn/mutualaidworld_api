class ScenarioResource < JSONAPI::Resource
  attributes :image, :verbdesc, :noundesc, :imagethumb, :lat, :lon

  belongs_to :verb
  belongs_to :noun
  belongs_to :requestor
  belongs_to :doer

  def noundesc
    @model.noun.description
  end

  def verbdesc
    @model.verb.description
  end

  def imagethumb
    @model.image.url(:thumb)
  end

  def lat
    @model.requestor.latitude
  end

    def lon
      @model.requestor.longitude
    end
end
