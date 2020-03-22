# == Schema Information
#
# Table name: donations
#
#  id          :bigint           not null, primary key
#  amount      :decimal(16, 3)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  donator_id  :bigint
#  scenario_id :bigint
#
# Indexes
#
#  index_donations_on_donator_id   (donator_id)
#  index_donations_on_scenario_id  (scenario_id)
#
# Foreign Keys
#
#  fk_rails_...  (donator_id => users.id)
#  fk_rails_...  (scenario_id => scenarios.id)
#
class Donation < ApplicationRecord
  belongs_to :scenario
  belongs_to :donator, class_name: "User", inverse_of: :donated
end
