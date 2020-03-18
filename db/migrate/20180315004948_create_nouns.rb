class CreateNouns < ActiveRecord::Migration[5.1]
  def change
    create_table :nouns do |t|
      t.string :description

      t.timestamps
    end
  end
end
