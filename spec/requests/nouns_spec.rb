require 'rails_helper'

RSpec.describe "Nouns", type: :request do
  describe "GET /nouns" do
    it "works! (now write some real specs)" do
      get nouns_path
      expect(response).to have_http_status(200)
    end
  end
end
