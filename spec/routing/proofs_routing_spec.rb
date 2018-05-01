require "rails_helper"

RSpec.describe ProofsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/proofs").to route_to("proofs#index")
    end

    it "routes to #new" do
      expect(get: "/proofs/new").to route_to("proofs#new")
    end

    it "routes to #show" do
      expect(get: "/proofs/1").to route_to("proofs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/proofs/1/edit").to route_to("proofs#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/proofs").to route_to("proofs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/proofs/1").to route_to("proofs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/proofs/1").to route_to("proofs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/proofs/1").to route_to("proofs#destroy", id: "1")
    end
  end
end
