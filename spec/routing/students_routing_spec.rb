require "rails_helper"

RSpec.describe "Routing to students", :type => :routing do

  it "routes GET /students/new to students#new" do
    expect(:get => "/students/new").to route_to("students#new")
  end

  it "routes GET /students/1 to students#show" do
    expect(:get => "/students/1").to route_to("students#show", :id => "1")
  end

  it "routes POST /students to students#create" do
    expect(:post => "/students").to route_to("students#create")
  end
end
