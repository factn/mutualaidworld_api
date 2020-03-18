require "rails_helper"

RSpec.describe AdTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/ad_types").to route_to("ad_types#index")
    end

    it "routes to #new" do
      expect(get: "/ad_types/new").to route_to("ad_types#new")
    end

    it "routes to #show" do
      expect(get: "/ad_types/1").to route_to("ad_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/ad_types/1/edit").to route_to("ad_types#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/ad_types").to route_to("ad_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/ad_types/1").to route_to("ad_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/ad_types/1").to route_to("ad_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/ad_types/1").to route_to("ad_types#destroy", id: "1")
    end
  end
end
