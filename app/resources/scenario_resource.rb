class ScenarioResource < JSONAPI::Resource
  attributes :image, :verb, :noun, :imagethumb, :requestorlat, :requestorlon, :doerlat, :doerlon, :donated

  has_one :verb
  has_one :noun
  has_one :requestor
  has_one :doer

  def noun
    @model.noun.description
  end

  def verb
    @model.verb.description
  end

  def imagethumb
    @model.image.url(:thumb)
  end

  def requestorlat
    @model.requestor.latitude
  end

  def requestorlon
    @model.requestor.longitude
  end

  def doerlat
    @model.doer.latitude
  end

  def doerlon
    @model.doer.longitude
  end

  def donated
    # TODO: store donations somehow
    "$57.34"
  end
end
