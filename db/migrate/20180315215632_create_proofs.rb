class CreateProofs < ActiveRecord::Migration[5.1]
  def change
    create_table :proofs do |t|
      t.references :scenario, foreign_key: true

      t.references :verifier, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
