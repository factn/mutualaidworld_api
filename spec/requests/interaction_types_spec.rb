require 'rails_helper'

RSpec.describe "InteractionTypes", type: :request do
  describe "GET /interaction_types" do
    it "works! (now write some real specs)" do
      get interaction_types_path
      expect(response).to have_http_status(200)
    end
  end
end
