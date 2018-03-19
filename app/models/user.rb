class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :requested, class_name: 'Scenario', dependent: :nullify, inverse_of: :requestor, foreign_key: :requestor_id
  has_many :solved, class_name: 'Scenario', dependent: :nullify, inverse_of: :solver, foreign_key: :solver_id

end
