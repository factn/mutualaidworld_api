require "rails_helper"

RSpec.describe ScenariosController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:verb) { FactoryBot.create(:verb) }
  let(:noun) { FactoryBot.create(:noun) }
  let(:event) { FactoryBot.create(:event) }
  let(:scenario) { FactoryBot.create(:scenario) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Scenario" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        # creating a scenario via the API creates 4 subtasks
        expect do
          post "/scenarios", headers: headers, params: { "data": { "type": "scenarios", "attributes": {}, "relationships": { "verb": { "data": { "id": verb.id, "type": "verbs" } }, "noun": { "data": { "id": noun.id, "type": "nouns" } }, "event": { "data": { "id": event.id, "type": "events" } } } } }.to_json
        end.to change(Scenario, :count).by(5)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates a scenarios doer" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect(scenario.doer_id).not_to equal(user.id)

        patch "/scenarios/#{scenario.id}", headers: headers, params: { "data": { "type": "scenarios", "id": scenario.id, "attributes": {}, "relationships": { "doer": { "data": { "id": user.id, "type": "users" } } } } }.to_json
        expect(response).to have_http_status(200)

        scenario.reload
        expect(scenario.doer_id).to equal(user.id)
      end
    end
  end
end
