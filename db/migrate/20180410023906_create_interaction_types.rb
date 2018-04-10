class CreateInteractionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :interaction_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
