require "rails_helper"

RSpec.describe InteractionTypesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/interaction_types").to route_to("interaction_types#index")
    end

    it "routes to #new" do
      expect(:get => "/interaction_types/new").to route_to("interaction_types#new")
    end

    it "routes to #show" do
      expect(:get => "/interaction_types/1").to route_to("interaction_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/interaction_types/1/edit").to route_to("interaction_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/interaction_types").to route_to("interaction_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/interaction_types/1").to route_to("interaction_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/interaction_types/1").to route_to("interaction_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/interaction_types/1").to route_to("interaction_types#destroy", :id => "1")
    end

  end
end
