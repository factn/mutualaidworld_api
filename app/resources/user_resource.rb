class UserResource < JSONAPI::Resource
  attributes :latitude, :longitude, :email, :firstname, :lastname, :password, :password_confirmation

  filters :latitude, :longitude, :email, :firstname, :lastname

  has_many :scenarios


  has_many :requested, class_name: 'Scenario'
  has_many :done, class_name: 'Scenario'

  has_many :donated, class_name: 'Donation'
  has_many :verified, class_name: 'Proof'

end
