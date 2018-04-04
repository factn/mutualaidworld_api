class ScenarioResource < JSONAPI::Resource
  attributes :image, :verb, :noun, :event, :imagethumb, :requesterlat, :requesterlon, :doerlat, :doerlon, :donated, :funding_goal
  attributes :requester_firstname, :requester_lastname, :doer_firstname, :doer_lastname, :parent_scenario, :parent_scenario_id

  has_one :verb
  has_one :noun
  has_one :requester
  has_one :doer
  has_one :event
  has_one :parent_scenario, class_name: 'Scenario'

  has_many :proofs
  has_many :donations
  has_many :children_scenario, class_name: 'Scenario'

  filters :verb, :noun, :event, :requester, :doer, :funding_goal, :parent_scenario, :parent_scenario_id

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
    @model.requester.firstname
  end

  def doer_firstname
    @model.doer.firstname
  end

  def requester_lastname
    @model.requester.lastname
  end

  def doer_lastname
    @model.doer.lastname
  end

  def requesterlat
    @model.requester.latitude
  end

  def requesterlon
    @model.requester.longitude
  end

  def doerlat
    @model.doer.latitude
  end

  def doerlon
    @model.doer.longitude
  end

  # def parent_scenario
  #   @model.parent_description
  # end

  def donated
    # TODO: store donations somehow
    "$57.34"
  end
end
