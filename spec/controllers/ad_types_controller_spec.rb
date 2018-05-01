require "rails_helper"

RSpec.describe AdTypesController, type: :request do
  describe "POST #create" do
    context "with valid params" do
      it "creates a new ad_type" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/ad_types", headers: headers, params: { "data": { "type": "ad_types", "attributes": { "description": "blaa" } } }.to_json
        end.to change(AdType, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:ad_type) { FactoryBot.create(:ad_type) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/ad_types", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": ad_type.id.to_s,
            "type": "ad_types",
            "links": {
              "self": "http://www.example.com/ad-types/#{ad_type.id}"
            },
            "attributes": {
              "description": ad_type.description.to_s,
              "created_at": JSON.parse(ad_type.created_at.to_json),
              "updated_at": JSON.parse(ad_type.updated_at.to_json)
            },
            "relationships": {
              "user_ad_interactions": {
                "links": {
                  "self": "http://www.example.com/ad-types/#{ad_type.id}/relationships/user-ad-interactions",
                  "related": "http://www.example.com/ad-types/#{ad_type.id}/user-ad-interactions"
                }
              }
            }
          }],
          "links": {
            "first": "http://www.example.com/ad-types?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/ad-types?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
