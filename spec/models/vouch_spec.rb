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
require "rails_helper"

RSpec.describe Vouch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
