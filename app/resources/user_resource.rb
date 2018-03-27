class UserResource < JSONAPI::Resource
  attributes :latitude, :longitude, :email, :firstname, :lastname

  def firstname
    "Place"
  end

  def lastname
    "Holder"
  end

end
