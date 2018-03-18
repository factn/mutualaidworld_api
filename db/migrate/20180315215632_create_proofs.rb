class CreateProofs < ActiveRecord::Migration[5.1]
  def change
    create_table :proofs do |t|
      t.references :mission, foreign_key: true

      t.timestamps
    end
  end
end
