class CreateAdTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :ad_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
