require 'rails_helper'

RSpec.describe ProofsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:scenario) { FactoryBot.create(:scenario) }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new proof" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/proofs", headers: headers, params: { "data":
                                                      { "type": "proofs",
                                                        "attributes": {},
                                                        "relationships":
                                                          { "verifier": { "data": { "id": user.id, "type": "users" } },
                                                            "scenario": { "data": { "id": scenario.id, "type": "scenarios" } } } } }.to_json
        end.to change(Proof, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET all" do
    let!(:proof) { FactoryBot.create(:proof) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }
        # binding.pry
        get "/proofs", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": proof.id.to_s,
            "type": "proofs",
            "links": {
              "self": "http://www.example.com/proofs/#{proof.id}"
            },
            "attributes": {
              "created_at": JSON.parse(proof.created_at.to_json),
              "updated_at": JSON.parse(proof.updated_at.to_json)
            },
            "relationships": {
              "verifier": {
                "links": {
                  "self": "http://www.example.com/proofs/#{proof.id}/relationships/verifier",
                  "related": "http://www.example.com/proofs/#{proof.id}/verifier"
                }
              },
              "scenario": {
                "links": {
                  "self": "http://www.example.com/proofs/#{proof.id}/relationships/scenario",
                  "related": "http://www.example.com/proofs/#{proof.id}/scenario"
                }
              }
            }
          }],
          "links": {
            "first": "http://www.example.com/proofs?page%5Blimit%5D=100&page%5Boffset%5D=0",
            "last": "http://www.example.com/proofs?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end
end
