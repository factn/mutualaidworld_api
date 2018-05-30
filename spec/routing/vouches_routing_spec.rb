require "rails_helper"

RSpec.describe VouchesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/vouches").to route_to("vouches#index")
    end

    it "routes to #new" do
      expect(get: "/vouches/new").to route_to("vouches#new")
    end

    it "routes to #show" do
      expect(get: "/vouches/1").to route_to("vouches#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/vouches/1/edit").to route_to("vouches#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/vouches").to route_to("vouches#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/vouches/1").to route_to("vouches#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/vouches/1").to route_to("vouches#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/vouches/1").to route_to("vouches#destroy", id: "1")
    end
  end
end
