class AddDescriptionToProofs < ActiveRecord::Migration[5.1]
  def change
    add_column :proofs, :description, :string
  end
end
