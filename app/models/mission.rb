class Mission < ApplicationRecord
  belongs_to :verb
  belongs_to :noun

  belongs_to :requestor, class_name: 'User', inverse_of: :requested
  belongs_to :solver, class_name: 'User', inverse_of: :solved

  has_many :proofs, dependent: :destroy
end
