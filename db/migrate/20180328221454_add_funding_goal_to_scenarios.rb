
class AddFundingGoalToScenarios < ActiveRecord::Migration[5.1]
  def change
    # some currencies have 3 numbers after the decimal place
    # max value 9,999,999,999,999.999
    add_column :scenarios, :funding_goal, :decimal, precision: 16, scale: 3
  end
end
