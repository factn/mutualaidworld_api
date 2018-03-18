class CreateVerbs < ActiveRecord::Migration[5.1]
  def change
    create_table :verbs do |t|
      t.string :description

      t.timestamps
    end
  end
end
