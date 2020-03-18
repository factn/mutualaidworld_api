class AddImageToScenarios < ActiveRecord::Migration[5.1]
  def up
    add_attachment :scenarios, :image
  end

  def down
    remove_attachment :scenarios, :image
  end
end
