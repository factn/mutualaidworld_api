class DonationResource < JSONAPI::Resource
  attributes :donator_firstname, :donator_lastname, :amount, :scenario, :created_at, :updated_at

  has_one :donator
  has_one :scenario

  filters :donator, :amount, :scenario

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
