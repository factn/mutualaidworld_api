require 'rails_helper'

RSpec.describe DonationsController, type: :request do
  let(:scenario) { FactoryBot.create(:scenario) }
  let(:user) { FactoryBot.create(:user) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Donation" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/donations", headers: headers, params: { "data": { "type": "donations", "attributes": { "amount": "17" }, "relationships": { "donator": { "data": { "type": "users", "id": user.id } }, "scenario": { "data": { "id": scenario.id, "type": "scenarios" } } } } }.to_json
        end.to change(Donation, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end
end
