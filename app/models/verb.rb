# == Schema Information
#
# Table name: verbs
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Verb < ApplicationRecord
  has_many :scenarios
end
