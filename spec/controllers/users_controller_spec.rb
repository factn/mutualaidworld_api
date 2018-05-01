require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/users", headers: headers, params: { "data": { "type": "users", "attributes": { "email": "user@example.com", "password": "password", "password_confirmation": "password" } } }.to_json
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "GET" do
    let!(:user) { FactoryBot.create(:user) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        get "/users", headers: headers

        response_json = JSON.parse(response.body)

        test_json = {
          "data": [{
            "id": user.id.to_s,
            "type": "users",
            "links": {
              "self": "http://www.example.com/users/#{user.id}"
            },
            "attributes": {
              "avatar": user.avatar.to_s,
              "latitude": user.latitude,
              "longitude": user.longitude,
              "email": user.email.to_s,
              "firstname": user.firstname.to_s,
              "lastname": user.lastname.to_s,
              "password": nil,
              "password_confirmation": nil,
              "default_total_session_donation": user.default_total_session_donation.to_s,
              "default_swipe_donation": user.default_swipe_donation.to_s,
              "created_at": JSON.parse(user.created_at.to_json),
              "updated_at": JSON.parse(user.updated_at.to_json)
            },
            "relationships": {
              "scenarios": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/scenarios", "related": "http://www.example.com/users/#{user.id}/scenarios"
                }
              },
              "requested": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/requested", "related": "http://www.example.com/users/#{user.id}/requested"
                }
              },
              "done": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/done", "related": "http://www.example.com/users/#{user.id}/done"
                }
              },
              "donated": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/donated", "related": "http://www.example.com/users/#{user.id}/donated"
                }
              },
              "verified": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/verified", "related": "http://www.example.com/users/#{user.id}/verified"
                }
              }
            }
          }],
          "links": {
            "first": "http://www.example.com/users?page%5Blimit%5D=100&page%5Boffset%5D=0", "last": "http://www.example.com/users?page%5Blimit%5D=100&page%5Boffset%5D=0"
          }
        }

        expect(response_json).to include_json(test_json)
      end

      it "gets one of them" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        get "/users/#{user.id}", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": {
            "id": user.id.to_s,
            "type": "users",
            "links": {
              "self": "http://www.example.com/users/#{user.id}"
            },
            "attributes": {
              "avatar": user.avatar.to_s,
              "latitude": user.latitude,
              "longitude": user.longitude,
              "email": user.email.to_s,
              "firstname": user.firstname.to_s,
              "lastname": user.lastname.to_s,
              "password": nil,
              "password_confirmation": nil,
              "default_total_session_donation": user.default_total_session_donation.to_s,
              "default_swipe_donation": user.default_swipe_donation.to_s,
              "created_at": JSON.parse(user.created_at.to_json),
              "updated_at": JSON.parse(user.updated_at.to_json)
            },
            "relationships": {
              "scenarios": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/scenarios", "related": "http://www.example.com/users/#{user.id}/scenarios"
                }
              },
              "requested": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/requested", "related": "http://www.example.com/users/#{user.id}/requested"
                }
              },
              "done": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/done", "related": "http://www.example.com/users/#{user.id}/done"
                }
              },
              "donated": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/donated", "related": "http://www.example.com/users/#{user.id}/donated"
                }
              },
              "verified": {
                "links": {
                  "self": "http://www.example.com/users/#{user.id}/relationships/verified", "related": "http://www.example.com/users/#{user.id}/verified"
                }
              }
            }
          }
        }

        expect(response_json).to include_json(test_json)
      end
    end
  end

  describe "PATCH" do
    let!(:user) { FactoryBot.create(:user) }

    context "with valid params" do
      it "updates the user" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        new_default_total_session_donation = "789.0"
        new_default_swipe_donation = "987.0"
        expect(user.default_total_session_donation.to_s).to_not equal(new_default_total_session_donation)
        expect(user.default_swipe_donation.to_s).to_not equal(new_default_swipe_donation)
        patch "/users/#{user.id}", headers: headers, params: { "data": { "type": "users", "id": "#{user.id}", "attributes": { "default_total_session_donation": new_default_total_session_donation, "default_swipe_donation": new_default_swipe_donation } } }.to_json

        user.reload

        expect(user.default_total_session_donation.to_s).to eq(new_default_total_session_donation)
        expect(user.default_swipe_donation.to_s).to eq(new_default_swipe_donation)
      end
    end
  end
end
