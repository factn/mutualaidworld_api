class CreateMissions < ActiveRecord::Migration[5.1]
  def change
    create_table :missions do |t|
      t.references :verb, foreign_key: true
      t.references :noun, foreign_key: true

      t.references :requestor, index: true, foreign_key: { to_table: :users }
      t.references :solver, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
