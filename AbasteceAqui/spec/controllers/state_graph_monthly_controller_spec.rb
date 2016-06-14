require 'rails_helper'

RSpec.describe StateGraphMonthlyController, type: :controller do

  before do
    @state1 = State.new(id: 1, name: "DISTRITO FEDERAL");
    @county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)
    @fuel_research1 = FuelResearch.new(id: 1, date: "2015-04-01", county_id: 1)
    @fuel_research2 = FuelResearch.new(id: 2, date: "2014-05-01", county_id: 1)
    @fuel1 = Fuel.new(id: 1, medium_resale_price: 3.0, fuel_type_id: 1, fuel_research_id: 1)
    @fuel2 = Fuel.new(id: 2, medium_resale_price: 5.0, fuel_type_id: 2, fuel_research_id: 1)
    @fuel3 = Fuel.new(id: 3, medium_resale_price: 4.0, fuel_type_id: 5, fuel_research_id: 2)


    @state1.save
    @county1.save
    @fuel_research1.save
    @fuel_research2.save
    @fuel1.save
    @fuel2.save
    @fuel3.save

  end

  describe "GET #state_monthly" do
    it "returns http success when state_searched != nil" do
      get :state_monthly, {:state_searched => @state1.name}
      expect(response).to have_http_status(:success)
    end
  end

  describe "#find_years" do
    it "should return all years" do 
      years = controller.find_years()
      expect(years.count).to eq(2)
    end
  end  

  describe "#create_fuels_hash" do
    it "should return hash of fuels" do
      fuels = controller.create_fuels_hash
      expect(fuels.count).to eq(12)
    end
  end

  describe "#calculate_media" do
    it "should return the array of medias" do
      fuels = controller.create_fuels_hash
      medias = controller.calculate_media(fuels)
      expect(medias.count).to eq(3)
    end
  end


end

  
