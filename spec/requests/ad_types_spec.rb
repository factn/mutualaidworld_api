require "rails_helper"

RSpec.describe "AdTypes", type: :request do
  describe "GET /ad_types" do
    it "works! (now write some real specs)" do
      get ad_types_path
      expect(response).to have_http_status(200)
    end
  end
end
