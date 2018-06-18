require "rails_helper"

RSpec.describe User, type: :model do
  let!(:vouch) { FactoryBot.create(:vouch) }
  let!(:doer) { vouch.scenario.doer }

  it "foo" do
    binding.pry
  end
end
