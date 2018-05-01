require "rails_helper"

RSpec.describe NounsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/nouns").to route_to("nouns#index")
    end

    it "routes to #new" do
      expect(get: "/nouns/new").to route_to("nouns#new")
    end

    it "routes to #show" do
      expect(get: "/nouns/1").to route_to("nouns#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/nouns/1/edit").to route_to("nouns#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/nouns").to route_to("nouns#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/nouns/1").to route_to("nouns#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/nouns/1").to route_to("nouns#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/nouns/1").to route_to("nouns#destroy", id: "1")
    end
  end
end
