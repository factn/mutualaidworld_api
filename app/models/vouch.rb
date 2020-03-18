class Vouch < ApplicationRecord
  validates :rating, numericality: { allow_nil: true,
                                     only_integer: false,
                                     greater_than_or_equal_to: 0,
                                     less_than_or_equal_to: 1 }

# we expect from the UI these 11 values, but, we don't enforce it as computers can rate to a higher precision
# 0.00
# 0.10
# 0.20
# 0.30
# 0.40
# 0.50
# 0.60
# 0.70
# 0.80
# 0.90
# 1.00

  # Validate the attached image is image/jpg, image/png, etc
  has_attached_file :image, styles: {
    thumb: "100x100>",
    square: "200x200#",
    medium: "300x300>"
  }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  belongs_to :scenario
  belongs_to :verifier, class_name: "User", inverse_of: :verified
end
