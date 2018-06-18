require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /events" do
    it "works! (now write some real specs)" do
      get events_path + "?email=#{user.email}&password=#{user.password}"
      expect(response).to have_http_status(200)
    end
  end
end
