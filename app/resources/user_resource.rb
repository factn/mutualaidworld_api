class UserResource < JSONAPI::Resource
  attributes :avatar, :avatarthumb, :latitude, :longitude, :email, :firstname, :lastname
  attributes :street_address
  attributes :city_state, :created_at, :updated_at

  filters :latitude, :longitude, :email, :firstname, :lastname, :street_address, :city_state, :created_at, :updated_at

  has_many :scenarios

  has_many :requested, class_name: "Scenario"
  has_many :done, class_name: "Scenario"

  def avatarthumb
    @model.avatar.url(:thumb)
  end
end
