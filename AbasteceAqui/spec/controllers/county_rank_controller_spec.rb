require 'rails_helper'

RSpec.describe CountyRankController, type: :controller do
  before do
    @state1 = State.new(id: 1, name: "PARA", region_id: 1)
    @state2 = State.new(id: 2, name: "MARANHAO", region_id: 2)
    @state3 = State.new(id: 3, name: "DISTRITO FEDERAL", region_id: 3);

    @county1 = County.new(id: 1, name: "BRASILIA", state_id: 3)
    @county2 = County.new(id: 2, name: "GAMA", state_id: 3)



    @fuel_research1 = FuelResearch.new(id:1, date:"2016-01-01", county_id: 1)
    @fuel_research2 = FuelResearch.new(id:2, date:"2016-02-01", county_id: 2)
    @fuel_research3 = FuelResearch.new(id:3, date:"2016-03-01", county_id: 1)
    @fuel_research2 = FuelResearch.new(id:4, date:"2016-03-01", county_id: 2)


    @county1.save
    @county2.save

    @fuel_research1.save
    @fuel_research2.save
    @fuel_research3.save

  end

  describe "#find_counties" do
    it "Should return two objects of counties" do
      counties = controller.find_counties
      expect(counties.count).to eq(2)
    end
  end

  describe "#find_last_research_of_counties" do
    it "Should return two objects of last research" do
      last_research = controller.find_last_research_of_counties(County.all)
      expect(last_research.count).to eq(2)
    end
  end

  describe "#find_county_fuels_last_research" do
    it "Should return two objects of fuel of last research" do
      fuels_last_research = controller.find_county_fuels_last_research(FuelResearch.all)
      expect(fuels_last_research.count).to eq(3)
    end
  end

  describe "#fill_researches_by_fuel_price(counties_fuels)" do
    it "Should return two objects of fuel of last research" do
      fuels_last_research = controller.fill_researches_by_fuel_price(controller.find_county_fuels_last_research(FuelResearch.all))
      expect(fuels_last_research.count).to eq(3)
    end
  end

  describe "#fill_researches_by_fuel_price(counties_fuels)" do
    it "Should return two objects of fuel of last research" do
      fuels_last_research = controller.fill_counties_by_fuel_price(controller.fill_researches_by_fuel_price(controller.find_county_fuels_last_research(FuelResearch.all)))
      expect(fuels_last_research.count).to eq(3)
    end
  end

  describe "#county_rank_by_date" do
		it "Should render database html" do
			get :county_rank_by_date
      expect(response).to have_http_status(:success)
    end
	end

end
