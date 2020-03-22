# == Schema Information
#
# Table name: nouns
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Noun < ApplicationRecord
  has_many :scenarios
end
