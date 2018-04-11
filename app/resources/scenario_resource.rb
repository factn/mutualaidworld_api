class ScenarioResource < JSONAPI::Resource
  attributes :image, :verb, :noun, :event, :imagethumb, :requesterlat, :requesterlon, :doerlat, :doerlon, :donated, :funding_goal
  attributes :requester_firstname, :requester_lastname, :doer_firstname, :doer_lastname

  has_one :verb
  has_one :noun
  has_one :requester
  has_one :doer
  has_one :event
  has_one :parent_scenario, class_name: 'Scenario'

  has_many :proofs
  has_many :donations
  has_many :children_scenario, class_name: 'Scenario'
  has_many :user_ad_interaction

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
    @model.requester.firstname if @model.requester
  end

  def doer_firstname
    @model.doer.firstname if @model.doer
  end

  def requester_lastname
    @model.requester.lastname if @model.requester
  end

  def doer_lastname
    @model.doer.lastname if @model.doer
  end

  def custom_message
    nil
  end
end
