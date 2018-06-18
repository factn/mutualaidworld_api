require "rails_helper"

RSpec.describe InteractionTypesController, type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new interaction_type" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/interaction_types?email=#{user.email}&password=#{user.password}", headers: headers, params: { "data": { "type": "interaction_types", "attributes": { "description": "blaa" } } }.to_json
        end.to change(InteractionType, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:interaction_type) { FactoryBot.create(:interaction_type) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/interaction_types?email=#{user.email}&password=#{user.password}", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": interaction_type.id.to_s,
            "type": "interaction_types",
            "links": {
              "self": "http://www.example.com/interaction-types/#{interaction_type.id}"
            },
            "attributes": {
              "description": interaction_type.description.to_s,
              "created_at": JSON.parse(interaction_type.created_at.to_json),
              "updated_at": JSON.parse(interaction_type.updated_at.to_json)
            },
            "relationships": {
            }
          }],
          "links": {
            "first": "http://www.example.com/interaction-types?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/interaction-types?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
