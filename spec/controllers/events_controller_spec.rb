require 'rails_helper'

RSpec.describe EventsController, type: :request do
  describe "POST #create" do
    context "with valid params" do
      it "creates a new event" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/events", headers: headers, params: { "data": { "type": "events", "attributes": { "description": "blaa" } } }.to_json
        end.to change(Event, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:event) { FactoryBot.create(:event) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/events", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": event.id.to_s,
            "type": "events",
            "links": {
              "self": "http://www.example.com/events/#{event.id}"
            },
            "attributes": {
              "description": event.description.to_s,
              "created_at": JSON.parse(event.created_at.to_json),
              "updated_at": JSON.parse(event.updated_at.to_json)
            },
            "relationships": {
            }
          }],
          "links": {
            "first": "http://www.example.com/events?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/events?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
