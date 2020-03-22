# == Schema Information
#
# Table name: verbs
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe Verb, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
