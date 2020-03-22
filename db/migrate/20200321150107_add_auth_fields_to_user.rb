class AddAuthFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :pin, :string
    add_column :users, :confirmed_at, :timestamp
    add_column :users, :token, :string
    add_column :users, :token_generated_at, :timestamp
    add_column :users, :confirmation_sent_at, :timestamp

    remove_column :users, :encrypted_password, :string
    remove_column :users, :hon3y, :string
    remove_column :users, :reset_password_token, :string
    remove_column :users, :reset_password_sent_at, :timestamp
    remove_column :users, :default_total_session_donation, :float
    remove_column :users, :default_swipe_donation, :float
  end
end
