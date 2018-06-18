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

        # creating a scenario via the API creates 6 subtasks
        expect do
          post "/scenarios?email=#{user.email}&password=#{user.password}", headers: headers, params: { "data": { "type": "scenarios", "attributes": {}, "relationships": { "verb": { "data": { "id": verb.id, "type": "verbs" } }, "noun": { "data": { "id": noun.id, "type": "nouns" } }, "event": { "data": { "id": event.id, "type": "events" } } } } }.to_json
        end.to change(Scenario, :count).by(7)

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

        patch "/scenarios/#{scenario.id}?email=#{user.email}&password=#{user.password}", headers: headers, params: { "data": { "type": "scenarios", "id": scenario.id, "attributes": {}, "relationships": { "doer": { "data": { "id": user.id, "type": "users" } } } } }.to_json
        expect(response).to have_http_status(200)

        scenario.reload
        expect(scenario.doer_id).to equal(user.id)
      end
    end
  end

  shared_examples "dismissed ads for a user" do |role|
    context "with #{role} dismissed" do
      let!(:dismissed_interaction) { FactoryBot.create(:user_ad_interaction, :dismissed, role.to_sym) }
      let!(:dismissed_scenario) { dismissed_interaction.scenario }
      let!(:a_dismisser) { dismissed_interaction.user }

      let!(:non_dismissed_scenario) { FactoryBot.create(:scenario) }

      it "gets undismissed #{role} scenarios for a user" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        get "/scenarios?email=#{user.email}&password=#{user.password}&filter[#{role}_ad_not_dismissed_by]=#{a_dismisser.id}", headers: headers

        expect(JSON.parse(response.body)["data"][0]["id"]).to eq(non_dismissed_scenario.id.to_s)

        expect(JSON.parse(response.body)["data"].length).to eq(1)
      end
    end
  end

  include_examples "dismissed ads for a user", "doer"
  include_examples "dismissed ads for a user", "donator"
  include_examples "dismissed ads for a user", "requester"
  include_examples "dismissed ads for a user", "verifier"
end
