class Proof < ApplicationRecord
  belongs_to :scenario
  belongs_to :verifier, class_name: "User", inverse_of: :verified

  has_attached_file :image, styles: {
    thumb: "100x100>",
    square: "200x200#",
    medium: "300x300>"
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
end
