class ScenarioResource < JSONAPI::Resource
  attributes :noun, :verb

  belongs_to :verb
  belongs_to :noun


  # belongs_to :requestor, class_name: 'User', inverse_of: :requested
  # belongs_to :doer, class_name: 'User', inverse_of: :solved
  #
  # has_many :proofs

  # has_many :ads
  #
  # has_attached_file :image, styles: {
  #   thumb: '100x100>',
  #   square: '200x200#',
  #   medium: '300x300>'
  # }
end
