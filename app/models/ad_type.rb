# == Schema Information
#
# Table name: ad_types
#
#  id          :bigint           not null, primary key
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AdType < ApplicationRecord
end
