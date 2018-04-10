class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :requested, class_name: 'Scenario', dependent: :nullify, inverse_of: :requester, foreign_key: :requester_id
  has_many :done, class_name: 'Scenario', dependent: :nullify, inverse_of: :doer, foreign_key: :doer_id

  has_many :donated, class_name: 'Donation', dependent: :nullify, inverse_of: :donator, foreign_key: :donator_id
  has_many :verified, class_name: 'Proof', dependent: :nullify, inverse_of: :verifier, foreign_key: :verifier_id

  def name
    firstname + ' ' + lastname
  end
end
