class CreateScenarios < ActiveRecord::Migration[5.1]
  def change
    create_table :scenarios do |t|
      t.references :verb, foreign_key: true
      t.references :noun, foreign_key: true

      t.references :requester, index: true, foreign_key: { to_table: :users }
      t.references :doer, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
