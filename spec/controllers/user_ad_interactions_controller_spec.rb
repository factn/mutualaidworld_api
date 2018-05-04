require "rails_helper"

RSpec.describe UserAdInteractionsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:ad_type) { FactoryBot.create(:ad_type) }
  let(:interaction_type) { FactoryBot.create(:interaction_type) }
  let(:dismissed) { FactoryBot.create(:interaction_type, :dismissed) }
  let(:served_to) { FactoryBot.create(:interaction_type, :served_to) }

  let(:scenario) { FactoryBot.create(:scenario) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user_ad_interaction" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/user_ad_interactions", headers: headers, params: { "data":
                                                                    { "type": "user_ad_interactions",
                                                                      "attributes": {},
                                                                      "relationships":
                                                                        { "user": { "data": { "id": user.id, "type": "users" } },
                                                                          "interaction_type": { "data": { "id": interaction_type.id, "type": "interaction_types" } },
                                                                          "ad_type": { "data": { "id": ad_type.id, "type": "ad_types" } },
                                                                          "scenario": { "data": { "id": scenario.id, "type": "scenarios" } } } } }.to_json
        end.to change(UserAdInteraction, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it "creates a new ad dismissal" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/user_ad_interactions", headers: headers, params: { "data":
                                                                    { "type": "user_ad_interactions",
                                                                      "attributes": {},
                                                                      "relationships":
                                                                        { "user": { "data": { "id": user.id, "type": "users" } },
                                                                          "interaction_type": { "data": { "id": dismissed.id, "type": "interaction_types" } },
                                                                          "ad_type": { "data": { "id": ad_type.id, "type": "ad_types" } },
                                                                          "scenario": { "data": { "id": scenario.id, "type": "scenarios" } } } } }.to_json
        end.to change(UserAdInteraction, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:user_ad_interaction) { FactoryBot.create(:user_ad_interaction) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/user_ad_interactions", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": user_ad_interaction.id.to_s,
            "type": "user_ad_interactions",
            "links": {
              "self": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}"
            },
            "attributes": {
              "firstname": user.firstname,
              "lastname": user.lastname,
              "scenario": scenario.description,
              "ad_type": ad_type.description,
              "interaction_type": interaction_type.description,
              "created_at": JSON.parse(user_ad_interaction.created_at.to_json),
              "updated_at": JSON.parse(user_ad_interaction.updated_at.to_json)
            },
            "relationships": {
              "user": {
                "links": {
                  "self": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/relationships/user",
                  "related": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/user"
                }
              },
              "scenario": {
                "links": {
                  "self": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/relationships/scenario",
                  "related": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/scenario"
                }
              },
              "ad_type": {
                "links": {
                  "self": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/relationships/ad-type",
                  "related": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/ad-type"
                }
              },
              "interaction_type": {
                "links": {
                  "self": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/relationships/interaction-type",
                  "related": "http://www.example.com/user-ad-interactions/#{user_ad_interaction.id}/interaction-type"
                }
              }
            }
          }],
          "links": {
            "first": "http://www.example.com/user-ad-interactions?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/user-ad-interactions?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
