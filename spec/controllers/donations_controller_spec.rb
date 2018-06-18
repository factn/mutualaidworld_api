require "rails_helper"

RSpec.describe DonationsController, type: :request do
  let(:scenario) { FactoryBot.create(:scenario) }
  let(:user) { FactoryBot.create(:user) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new donation" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/donations?email=#{user.email}&password=#{user.password}", headers: headers, params: { "data": { "type": "donations", "attributes": { "amount": "17" }, "relationships": { "donator": { "data": { "type": "users", "id": user.id } }, "scenario": { "data": { "id": scenario.id, "type": "scenarios" } } } } }.to_json
        end.to change(Donation, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:donation) { FactoryBot.create(:donation) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/donations?email=#{user.email}&password=#{user.password}", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": donation.id.to_s,
            "type": "donations",
            "links": {
              "self": "http://www.example.com/donations/#{donation.id}"
            },
            "attributes": {
              "amount": donation.amount.to_s,
              "created_at": JSON.parse(donation.created_at.to_json),
              "updated_at": JSON.parse(donation.updated_at.to_json)
            },
            "relationships": {
            }
          }],
          "links": {
            "first": "http://www.example.com/donations?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/donations?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
