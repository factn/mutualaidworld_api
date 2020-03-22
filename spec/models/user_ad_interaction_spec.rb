# == Schema Information
#
# Table name: user_ad_interactions
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ad_type_id          :bigint
#  interaction_type_id :bigint
#  scenario_id         :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_user_ad_interactions_on_ad_type_id           (ad_type_id)
#  index_user_ad_interactions_on_interaction_type_id  (interaction_type_id)
#  index_user_ad_interactions_on_scenario_id          (scenario_id)
#  index_user_ad_interactions_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (ad_type_id => ad_types.id)
#  fk_rails_...  (interaction_type_id => interaction_types.id)
#  fk_rails_...  (scenario_id => scenarios.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe UserAdInteraction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
