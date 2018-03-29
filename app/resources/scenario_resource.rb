class ScenarioResource < JSONAPI::Resource
  attributes :image, :verb, :noun, :event, :imagethumb, :requesterlat, :requesterlon, :doerlat, :doerlon, :donated, :funding_goal
  attributes :requester_firstname, :requester_lastname, :doer_firstname, :doer_lastname

  has_one :verb
  has_one :noun
  has_one :requestor
  has_one :doer
  has_one :event

  def noun
    @model.noun.description
  end

  def verb
    @model.verb.description
  end

  def event
    @model.event.description
  end

  def imagethumb
    @model.image.url(:thumb)
  end

  def requester_firstname
    @model.requestor.firstname
  end

  def doer_firstname
    @model.doer.firstname
  end

  def requester_lastname
    @model.requestor.lastname
  end

  def doer_lastname
    @model.doer.lastname
  end

  def requesterlat
    @model.requestor.latitude
  end

  def requesterlon
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
