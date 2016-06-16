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

  describe "#ethanol_sorted" do
    it "should returns an array with 1 elements" do

      fuels = Fuel.all
      ethanol_sorted = Fuel.ethanol_sorted(fuels)

      expect(ethanol_sorted.count).to eq(1)

    end
  end

  describe "#gasoline_sorted" do
    it "should returns an array with 1 elements" do

      fuels = Fuel.all
      gasoline_sorted = Fuel.gasoline_sorted(fuels)

      expect(gasoline_sorted.count).to eq(1)

    end
  end

  describe "#diesel_sorted" do
    it "should returns an array with 1 elements" do

      fuels = Fuel.all
      diesel_sorted = Fuel.diesel_sorted(fuels)

      expect(diesel_sorted.count).to eq(1)

    end
  end

  describe "#find_fuels_by_month" do
    it "should return an array with medium resale prices organized by fuel type" do

      fuels = Fuel.all()

      fuels_type_array = Fuel.find_fuels_by_month(fuels)

      expect(fuels_type_array.count).to eq(12)

    end
  end

end
