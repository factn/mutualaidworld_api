require "rails_helper"

RSpec.describe "UserAdInteractions", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /user_ad_interactions" do
    it "works! (now write some real specs)" do
      get user_ad_interactions_path + "?email=#{user.email}&password=#{user.password}"
      expect(response).to have_http_status(200)
    end
  end
end
