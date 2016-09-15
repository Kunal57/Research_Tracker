require "rails_helper"

RSpec.describe "Routing to professors", :type => :routing do

  it "routes GET /professors/new to professors#new" do
    expect(:get => "/professors/new").to route_to("professors#new")
  end

  it "routes GET /professors/1 to professors#show" do
    expect(:get => "/professors/1").to route_to("professors#show", :id => "1")
  end

  it "routes POST /professors to professors#create" do
    expect(:post => "/professors").to route_to("professors#create")
  end
end
