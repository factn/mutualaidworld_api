class AddImageToProof < ActiveRecord::Migration[5.1]
  def up
    add_attachment :proofs, :image
  end

  def down
    remove_attachment :proofs, :image
  end
end
