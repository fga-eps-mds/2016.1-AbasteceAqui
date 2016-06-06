require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do

  before do
    @state1 = State.new(id: 1, name: "DISTRITO FEDERAL");
    @county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)
    @fuel_research1 = FuelResearch.new(id: 1, date: "2016-04-01", county_id: 1)
    @fuel_research2 = FuelResearch.new(id: 2, date: "2016-05-01", county_id: 1)
    @fuel1 = Fuel.new(id: 1, medium_resale_price: 3.0)
    @fuel2 = Fuel.new(id: 2, medium_resale_price: 5.0)


    @state1.save
    @county1.save
    @fuel_research1.save
    @fuel_research2.save
    @fuel1.save
    @fuel2.save



  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
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
      prices_of_fuel = []
      prices_of_fuel << @fuel1
      prices_of_fuel << @fuel2

      price_fuel = controller.calculate_price_fuel(prices_of_fuel)
      expect(price_fuel).to eql(4.0)
    end
  end

end
