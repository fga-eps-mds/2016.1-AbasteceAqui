require 'rails_helper'

RSpec.describe CountyGraphYearController, type: :controller do

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


  describe "GET #county_anual" do
    it "returns http success when state_searched != nil" do
      get :county_anual, {:state_searched => @state1.name}
      expect(response).to have_http_status(:success)
    end

    it "returns http success when county_searched != nil" do
      get :county_anual, {:county_searched => @county1.name}
      expect(response).to have_http_status(:success)
    end
  end

  describe "#fuels_of_year" do
    it "should return a hash of years" do
      years = [2013,2014,2015]
      years_of_researches = Hash.new

      years_of_researches[2013] = Hash.new
      years_of_researches[2014] = Hash.new
      years_of_researches[2015] = Hash.new

      expect(years_of_researches.count).to eq(3)

    end
  end

  describe "#calculate_price_fuel" do
    it "should returns 4.0" do
      prices_of_fuel = Fuel.all

      price_fuel = controller.calculate_price_fuel(prices_of_fuel)
      expect(price_fuel).to eql(4.0)
    end
  end

  describe "#verify_type_of_fuel" do
    it "should returns an array with 1 element, when fuel_type_id = 1" do
      fuels = Fuel.all

      gas_prices = []
      diesel_prices = []
      ethanol_prices = []

      controller.verify_type_of_fuel(fuels, ethanol_prices, gas_prices, diesel_prices)

      expect(ethanol_prices.count).to eq(1)
    end

    it "should returns an array with 1 element, when fuel_type_id = 5" do
      fuels = Fuel.all

      gas_prices = []
      diesel_prices = []
      ethanol_prices = []

      controller.verify_type_of_fuel(fuels, ethanol_prices, gas_prices, diesel_prices)

      expect(diesel_prices.count).to eq(1)
    end
  end

  describe "#check_year_of_research" do
    it "should an array with 2 elelements, when the year of research = 2015" do
      researches_of_county = @county1.fuel_researches
      researches_of_year = []

      controller.check_year_of_research(researches_of_county, researches_of_year, 2015)

      expect(researches_of_year.count).to eq(2)
    end
  end

end #end of class
