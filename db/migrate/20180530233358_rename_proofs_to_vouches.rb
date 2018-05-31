class RenameProofsToVouches < ActiveRecord::Migration[5.1]
  def change
    rename_table :proofs, :vouches
  end
end
