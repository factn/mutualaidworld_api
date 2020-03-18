class Donation < ApplicationRecord
  belongs_to :scenario
  belongs_to :donator, class_name: "User", inverse_of: :donated
end
