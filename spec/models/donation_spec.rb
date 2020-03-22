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
require "rails_helper"

RSpec.describe Donation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
