class DonationResource < JSONAPI::Resource
  attributes :donator_firstname, :donator_lastname, :amount, :scenario

  has_one :donator
  has_one :scenario

  def scenario
    @model.scenario.description
  end

  def donator_firstname
    @model.donator.firstname
  end

  def donator_lastname
    @model.donator.lastname
  end
end
