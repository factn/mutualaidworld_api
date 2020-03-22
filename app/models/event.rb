# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  description   :string
#  location_name :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Event < ApplicationRecord
  has_many :scenarios
end
