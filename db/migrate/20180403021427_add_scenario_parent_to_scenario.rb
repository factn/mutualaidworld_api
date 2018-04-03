class AddScenarioParentToScenario < ActiveRecord::Migration[5.1]
  def change
    add_reference :scenarios, :parent_scenario, foreign_key: { to_table: :scenarios }
  end
end
