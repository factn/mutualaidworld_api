class ScenarioResource < JSONAPI::Resource
  attributes :image, :verb, :noun, :event, :imagethumb, :requesterlat, :requesterlon, :doerlat, :doerlon, :donated, :funding_goal, :verified
  attributes :requester_firstname, :requester_lastname, :doer_firstname, :doer_lastname, :custom_message, :parent_scenario_id
  attributes :ratio_for_user, :is_parent, :is_child, :is_complete

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

  filters :noun, :verb, :event, :requester, :doer, :funding_goal, :parent_scenario, :parent_scenario_id
  filters :custom_message, :verified

  filter :is_sub_task, apply: ->(records, value, _options) {
    clause = "parent_scenario_id is null"

    clause = "parent_scenario_id is not null" if value[0]

    records.where(clause)
  }

  filter :is_parent, apply: ->(records, _value, _options) {
    clause = "parent_scenario_id is null"

    records.where(clause)
  }

  filter :is_child, apply: ->(records, _value, _options) {
    clause = "parent_scenario_id is not null"

    records.where(clause)
  }

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

  def ratio_for_user
    @model.ratio_for_user @context[:current_user]
  end

  def is_parent
    @model.is_parent
  end

  def is_child
    @model.is_child
  end

  def is_complete
    @model.is_complete
  end

end
