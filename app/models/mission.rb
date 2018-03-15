class Mission < ApplicationRecord
  belongs_to :verb
  belongs_to :noun

  belongs_to :requestor, class_name: 'User'
  belongs_to :solver, class_name: 'User'

end
