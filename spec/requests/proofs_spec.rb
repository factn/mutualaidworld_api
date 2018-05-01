require "rails_helper"

RSpec.describe "Proofs", type: :request do
  describe "GET /proofs" do
    it "works! (now write some real specs)" do
      get proofs_path
      expect(response).to have_http_status(200)
    end
  end
end
