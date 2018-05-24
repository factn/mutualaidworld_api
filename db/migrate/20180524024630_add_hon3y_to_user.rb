class AddHon3yToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hon3y, :float
  end
end
