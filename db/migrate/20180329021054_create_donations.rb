class CreateDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :donations do |t|
      t.decimal :amount, precision: 16, scale: 3

      t.references :donator, index: true, foreign_key: { to_table: :users }
      t.references :scenario, index: true, foreign_key: {}

      t.timestamps
    end
  end
end
