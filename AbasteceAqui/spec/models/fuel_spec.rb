require "rails_helper"

RSpec.describe Fuel,  type: :model do

  before do
    fuel_research1 = FuelResearch.new(id: 1, date: "2015-02-01", county_id: 1)
		fuel_research2 = FuelResearch.new(id: 2, date: "2016-02-01", county_id: 2)

		fuel_research1.save
		fuel_research2.save

    fuel1 = Fuel.new(id: 1, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.199,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 1, fuel_type_id: 1)
    fuel2 = Fuel.new(id: 2, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.199,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 1, fuel_type_id: 2)

    fuel3 = Fuel.new(id: 3, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.199,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 2, fuel_type_id: 5)

    fuel1.save
    fuel2.save
    fuel3.save
  end

  describe "#fuels_latest_researches_counties" do
    it "should returns an array with 3 elements" do
      researches = FuelResearch.all
      fuels = Fuel.fuels_latest_researches_counties(researches)

      expect(fuels.count).to eq(3)

    end
  end

  describe "#fuels_latest_researches_counties" do
    it "should returns an array with 3 elements" do
      researches = FuelResearch.all
      fuels = Fuel.county_fuels_last_research_order(researches)

      expect(fuels.count).to eq(3)

    end
  end

end
