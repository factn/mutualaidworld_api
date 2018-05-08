class UserResource < JSONAPI::Resource
  attributes :avatar, :avatarthumb, :latitude, :longitude, :email, :firstname, :lastname, :password
  attributes :password_confirmation, :default_total_session_donation, :default_swipe_donation, :street_address
  attributes :city_state, :created_at, :updated_at

  filters :latitude, :longitude, :email, :firstname, :lastname, :street_address, :city_state, :created_at, :updated_at

  has_many :scenarios

  has_many :requested, class_name: "Scenario"
  has_many :done, class_name: "Scenario"

  has_many :donated, class_name: "Donation"
  has_many :verified, class_name: "Proof"

  def avatarthumb
    @model.avatar.url(:thumb)
  end
end
