require "rails_helper"

RSpec.describe "Verbs", type: :request do
  describe "GET /verbs" do
    it "works! (now write some real specs)" do
      get verbs_path
      expect(response).to have_http_status(200)
    end
  end
end
