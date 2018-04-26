class UserAdInteractionResource < JSONAPI::Resource
  attributes :firstname, :lastname, :scenario, :ad_type, :interaction_type, :created_at, :updated_at

  has_one :user
  has_one :scenario
  has_one :ad_type
  has_one :interaction_type

  filters :user, :scenario, :ad_type, :interaction_type

  def scenario
    @model.scenario.description
  end

  def ad_type
    @model.ad_type.description
  end

  def interaction_type
    @model.interaction_type.description
  end

  def firstname
    @model.user.firstname
  end

  def lastname
    @model.user.lastname
  end



  # def donator_firstname
  #   @model.donator.firstname
  # end
  #
  # def donator_lastname
  #   @model.donator.lastname
  # end
end
