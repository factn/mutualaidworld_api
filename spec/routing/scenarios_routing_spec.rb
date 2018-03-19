require "rails_helper"

RSpec.describe ScenariosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scenarios").to route_to("scenarios#index")
    end

    it "routes to #new" do
      expect(:get => "/scenarios/new").to route_to("scenarios#new")
    end

    it "routes to #show" do
      expect(:get => "/scenarios/1").to route_to("scenarios#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scenarios/1/edit").to route_to("scenarios#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scenarios").to route_to("scenarios#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scenarios/1").to route_to("scenarios#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scenarios/1").to route_to("scenarios#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scenarios/1").to route_to("scenarios#destroy", :id => "1")
    end

  end
end
