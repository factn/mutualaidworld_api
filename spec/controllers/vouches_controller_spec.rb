require "rails_helper"

RSpec.describe VouchesController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:scenario) { FactoryBot.create(:scenario) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new vouch" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/vouches", headers: headers, params: { "data":
                                                      { "type": "vouches",
                                                        "attributes": {},
                                                        "relationships":
                                                          { "verifier": { "data": { "id": user.id, "type": "users" } },
                                                            "scenario": { "data": { "id": scenario.id, "type": "scenarios" } } } } }.to_json
        end.to change(Vouch, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:vouch) { FactoryBot.create(:vouch) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/vouches", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": vouch.id.to_s,
            "type": "vouches",
            "links": {
              "self": "http://www.example.com/vouches/#{vouch.id}"
            },
            "attributes": {
              "created_at": JSON.parse(vouch.created_at.to_json),
              "updated_at": JSON.parse(vouch.updated_at.to_json)
            },
            "relationships": {
              "verifier": {
                "links": {
                  "self": "http://www.example.com/vouches/#{vouch.id}/relationships/verifier",
                  "related": "http://www.example.com/vouches/#{vouch.id}/verifier"
                }
              },
              "scenario": {
                "links": {
                  "self": "http://www.example.com/vouches/#{vouch.id}/relationships/scenario",
                  "related": "http://www.example.com/vouches/#{vouch.id}/scenario"
                }
              }
            }
          }],
          "links": {
            "first": "http://www.example.com/vouches?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/vouches?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
