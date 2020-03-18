require "rails_helper"

RSpec.describe VerbsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/verbs").to route_to("verbs#index")
    end

    it "routes to #new" do
      expect(get: "/verbs/new").to route_to("verbs#new")
    end

    it "routes to #show" do
      expect(get: "/verbs/1").to route_to("verbs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/verbs/1/edit").to route_to("verbs#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/verbs").to route_to("verbs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/verbs/1").to route_to("verbs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/verbs/1").to route_to("verbs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/verbs/1").to route_to("verbs#destroy", id: "1")
    end
  end
end
