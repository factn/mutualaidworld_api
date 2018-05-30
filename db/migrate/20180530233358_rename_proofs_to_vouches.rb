class RenameVouchesToVouches < ActiveRecord::Migration[5.1]
  def change
    rename_table :vouches, :vouches
  end
end
