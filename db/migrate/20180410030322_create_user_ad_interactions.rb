class CreateUserAdInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ad_interactions do |t|
      t.references :user, foreign_key: true
      t.references :interaction_type, foreign_key: true
      t.references :ad_type, foreign_key: true
      t.references :scenario, foreign_key: true

      t.timestamps
    end
  end
end
