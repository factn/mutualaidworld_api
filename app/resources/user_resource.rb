class UserResource < JSONAPI::Resource
  attributes :latitude, :longitude, :email, :firstname, :lastname

  filters :latitude, :longitude, :email, :firstname, :lastname
end
