class AddCustomMessageToScenarios < ActiveRecord::Migration[5.1]
  def change
    add_column :scenarios, :custom_message, :string
  end
end
