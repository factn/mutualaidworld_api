require "rails_helper"

RSpec.describe UserAdInteractionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_ad_interactions").to route_to("user_ad_interactions#index")
    end

    it "routes to #new" do
      expect(get: "/user_ad_interactions/new").to route_to("user_ad_interactions#new")
    end

    it "routes to #show" do
      expect(get: "/user_ad_interactions/1").to route_to("user_ad_interactions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_ad_interactions/1/edit").to route_to("user_ad_interactions#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/user_ad_interactions").to route_to("user_ad_interactions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_ad_interactions/1").to route_to("user_ad_interactions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_ad_interactions/1").to route_to("user_ad_interactions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_ad_interactions/1").to route_to("user_ad_interactions#destroy", id: "1")
    end
  end
end
