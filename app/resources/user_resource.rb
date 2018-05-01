class UserResource < JSONAPI::Resource
  attributes :avatar, :avatarthumb, :latitude, :longitude, :email, :firstname, :lastname, :password, :password_confirmation, :created_at, :updated_at

  filters :latitude, :longitude, :email, :firstname, :lastname

  has_many :scenarios

  has_many :requested, class_name: "Scenario"
  has_many :done, class_name: "Scenario"

  has_many :donated, class_name: "Donation"
  has_many :verified, class_name: "Proof"

  def avatarthumb
    @model.avatar.url(:thumb)
  end
end
