require "rails_helper"

RSpec.describe VerbsController, type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new verb" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/verbs?email=#{user.email}&password=#{user.password}", headers: headers, params: { "data": { "type": "verbs", "attributes": { "description": "blaa" } } }.to_json
        end.to change(Verb, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:verb) { FactoryBot.create(:verb) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/verbs?email=#{user.email}&password=#{user.password}", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": verb.id.to_s,
            "type": "verbs",
            "links": {
              "self": "http://www.example.com/verbs/#{verb.id}"
            },
            "attributes": {
              "description": verb.description.to_s,
              "created_at": JSON.parse(verb.created_at.to_json),
              "updated_at": JSON.parse(verb.updated_at.to_json)
            },
            "relationships": {
            }
          }],
          "links": {
            "first": "http://www.example.com/verbs?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/verbs?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
