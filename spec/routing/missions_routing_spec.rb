require "rails_helper"

RSpec.describe MissionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/missions").to route_to("missions#index")
    end

    it "routes to #new" do
      expect(:get => "/missions/new").to route_to("missions#new")
    end

    it "routes to #show" do
      expect(:get => "/missions/1").to route_to("missions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/missions/1/edit").to route_to("missions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/missions").to route_to("missions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/missions/1").to route_to("missions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/missions/1").to route_to("missions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/missions/1").to route_to("missions#destroy", :id => "1")
    end

  end
end
