# == Schema Information
#
# Table name: vouches
#
#  id                 :bigint           not null, primary key
#  description        :string
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  rating             :decimal(3, 2)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  scenario_id        :bigint
#  verifier_id        :bigint
#
# Indexes
#
#  index_vouches_on_scenario_id  (scenario_id)
#  index_vouches_on_verifier_id  (verifier_id)
#
# Foreign Keys
#
#  fk_rails_...  (scenario_id => scenarios.id)
#  fk_rails_...  (verifier_id => users.id)
#
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
