require "rails_helper"

RSpec.describe NounsController, type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new noun" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/nouns?email=#{user.email}&password=#{user.password}", headers: headers, params: { "data": { "type": "nouns", "attributes": { "description": "blaa" } } }.to_json
        end.to change(Noun, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:noun) { FactoryBot.create(:noun) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/nouns?email=#{user.email}&password=#{user.password}", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": noun.id.to_s,
            "type": "nouns",
            "links": {
              "self": "http://www.example.com/nouns/#{noun.id}"
            },
            "attributes": {
              "description": noun.description.to_s,
              "created_at": JSON.parse(noun.created_at.to_json),
              "updated_at": JSON.parse(noun.updated_at.to_json)
            },
            "relationships": {
            }
          }],
          "links": {
            "first": "http://www.example.com/nouns?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/nouns?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
