class UserAdInteraction < ApplicationRecord
  belongs_to :user
  belongs_to :interaction_type
  belongs_to :ad_type
  belongs_to :scenario
end
