class AddDefaultDonationAmountsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :default_total_session_donation, :decimal, precision: 16, scale: 3
    add_column :users, :default_swipe_donation, :decimal, precision: 16, scale: 3
  end
end
