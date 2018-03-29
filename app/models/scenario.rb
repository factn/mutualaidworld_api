class Scenario < ApplicationRecord
  belongs_to :verb
  belongs_to :noun
  belongs_to :event
  belongs_to :requester, class_name: 'User', inverse_of: :requested
  belongs_to :doer, class_name: 'User', inverse_of: :solved

  has_many :proofs, dependent: :destroy
  has_many :ads

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
end
