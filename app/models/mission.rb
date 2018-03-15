class Mission < ApplicationRecord
  belongs_to :verb
  belongs_to :noun

  belongs_to :requestor, class_name: 'User'
  belongs_to :solver, class_name: 'User'

  def update(parameters)
    binding.pry
    location = [parameters[:longitude], parameters[:latitude]]

    parameters.merge location: location

    super(parameters)
  end

  private

end
