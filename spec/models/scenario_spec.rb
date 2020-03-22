# == Schema Information
#
# Table name: scenarios
#
#  id                 :bigint           not null, primary key
#  custom_message     :string
#  funding_goal       :decimal(16, 3)
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  doer_id            :bigint
#  event_id           :bigint
#  noun_id            :bigint
#  parent_scenario_id :bigint
#  requester_id       :bigint
#  verb_id            :bigint
#
# Indexes
#
#  index_scenarios_on_doer_id             (doer_id)
#  index_scenarios_on_event_id            (event_id)
#  index_scenarios_on_noun_id             (noun_id)
#  index_scenarios_on_parent_scenario_id  (parent_scenario_id)
#  index_scenarios_on_requester_id        (requester_id)
#  index_scenarios_on_verb_id             (verb_id)
#
# Foreign Keys
#
#  fk_rails_...  (doer_id => users.id)
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (noun_id => nouns.id)
#  fk_rails_...  (parent_scenario_id => scenarios.id)
#  fk_rails_...  (requester_id => users.id)
#  fk_rails_...  (verb_id => verbs.id)
#
require "rails_helper"

RSpec.describe Scenario, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
