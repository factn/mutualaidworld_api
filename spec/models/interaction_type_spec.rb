# == Schema Information
#
# Table name: interaction_types
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe InteractionType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
