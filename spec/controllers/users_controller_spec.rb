require "rails_helper"

def get_with_authorization(path, options)
  options[:headers] ||= {
    "Accept": "application/vnd.api+json",
    "Content-Type": "application/vnd.api+json",
    "HTTP-AUTHORIZATION': 'Token token=\"#{user.token}\"" }
  }
  super
end


RSpec.describe UsersController, type: :request do
  let!(:logged_in_user) { FactoryBot.create(:user) }

  describe "POST #verify" do
    before do
      logged_in_user.generate_pin
    end

    subject { post "/users/verify", headers: headers, params: { user_id: logged_in_user.id, pin: pin }.to_json }

    context "with matching pin" do
      let(:pin) { logged_in_user.pin }

      it "verifies the user" do
        expect { subject }.to change { logged_in_user.reload.confirmed_at }

        expect(JSON.parse(response.body)).to eq({ "token" => logged_in_user.token })
      end
    end

    context "with non-matching pin" do
      let(:pin) { 'fucking_garbage' }

      it "does not verify the user" do
        subject

        expect(logged_in_user.confirmed_at).to eq nil
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect do
          post "/users", headers: headers, params: { "data": { "type": "users", "attributes": { "phone": "7326106948" } } }.to_json
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
        binding.pry
      end
    end
  end

  describe "GET" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }

    context "with valid params" do
      it "gets them all" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        get "/users?email=#{logged_in_user.email}&password=#{logged_in_user.password}", headers: headers

        response_json = JSON.parse(response.body)

        test_json = {
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

        expect(response_json).to include_json(data: UnorderedArray(test_json))
      end

      it "gets one of them" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        get "/users/#{user.id}?email=#{logged_in_user.email}&password=#{logged_in_user.password}", headers: headers

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
              "street_address":  user.street_address.to_s,
              "city_state":  user.city_state.to_s,
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

      it "gets them by a filter" do
        headers = {
          "Accept": "application/vnd.api+json",
          "Content-Type": "application/vnd.api+json"
        }

        expect(user.city_state.to_s).to_not eq("New Donk City")
        expect(user2.city_state.to_s).to_not eq("New Donk City")

        patch "/users/#{user2.id}?email=#{logged_in_user.email}&password=#{logged_in_user.password}", headers: headers, params: {
          "data": {
            "type": "users",
            "id": user2.id.to_s,
            "attributes": {
              "city_state": "New Donk City"
            }
          }
        }.to_json

        user2.reload
        get "/users?email=#{logged_in_user.email}&password=#{logged_in_user.password}&filter[city_state]=New Donk City", headers: headers

        response_json = JSON.parse(response.body)
        test_json = {
          "data": [{
            "id": user2.id.to_s,
            "type": "users",
            "links": {
              "self": "http://www.example.com/users/#{user2.id}"
            },
            "attributes": {
              "avatar": user2.avatar.to_s,
              "latitude": user2.latitude,
              "longitude": user2.longitude,
              "email": user2.email.to_s,
              "firstname": user2.firstname.to_s,
              "lastname": user2.lastname.to_s,
              "password": nil,
              "password_confirmation": nil,
              "default_total_session_donation": user2.default_total_session_donation.to_s,
              "default_swipe_donation": user2.default_swipe_donation.to_s,
              "street_address":  user2.street_address.to_s,
              "city_state":  user2.city_state.to_s,
              "created_at": JSON.parse(user2.created_at.to_json),
              "updated_at": JSON.parse(user2.updated_at.to_json)
            },
            "relationships": {
              "scenarios": {
                "links": {
                  "self": "http://www.example.com/users/#{user2.id}/relationships/scenarios",
                  "related": "http://www.example.com/users/#{user2.id}/scenarios"
                }
              },
              "requested": {
                "links": {
                  "self": "http://www.example.com/users/#{user2.id}/relationships/requested",
                  "related": "http://www.example.com/users/#{user2.id}/requested"
                }
              },
              "done": {
                "links": {
                  "self": "http://www.example.com/users/#{user2.id}/relationships/done",
                  "related": "http://www.example.com/users/#{user2.id}/done"
                }
              },
              "donated": {
                "links": {
                  "self": "http://www.example.com/users/#{user2.id}/relationships/donated",
                  "related": "http://www.example.com/users/#{user2.id}/donated"
                }
              },
              "verified": {
                "links": {
                  "self": "http://www.example.com/users/#{user2.id}/relationships/verified",
                  "related": "http://www.example.com/users/#{user2.id}/verified"
                }
              }
            }
          }]
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
        new_street_address = "streetaddress"
        new_city_state = "citystate"

        expect(user.default_total_session_donation.to_s).to_not equal(new_default_total_session_donation)
        expect(user.default_swipe_donation.to_s).to_not equal(new_default_swipe_donation)
        expect(user.street_address.to_s).to_not eq(new_street_address)
        expect(user.city_state.to_s).to_not eq(new_city_state)

        patch "/users/#{user.id}?email=#{logged_in_user.email}&password=#{logged_in_user.password}", headers: headers, params: {
          "data": {
            "type": "users",
            "id": user.id.to_s,
            "attributes": {
              "default_total_session_donation": new_default_total_session_donation,
              "default_swipe_donation": new_default_swipe_donation,
              "street_address": new_street_address,
              "city_state": new_city_state
            }
          }
        }.to_json

        user.reload

        expect(user.default_total_session_donation.to_s).to eq(new_default_total_session_donation)
        expect(user.default_swipe_donation.to_s).to eq(new_default_swipe_donation)
        expect(user.street_address.to_s).to eq(new_street_address)
        expect(user.city_state.to_s).to eq(new_city_state)
      end
    end
  end
end
