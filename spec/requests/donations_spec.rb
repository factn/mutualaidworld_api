require "rails_helper"

RSpec.describe "Donations", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /donations" do
    it "works! (now write some real specs)" do
      get donations_path + "?email=#{user.email}&password=#{user.password}"
      expect(response).to have_http_status(200)
    end
  end
end
