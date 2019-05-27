class AddEventIdToScenarios < ActiveRecord::Migration[5.1]
  def change
    add_reference :scenarios, :event, foreign_key: true
  end
end
