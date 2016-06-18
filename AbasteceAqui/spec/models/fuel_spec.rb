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

  describe "#sort_fuel_by_type" do
    it "should returns an array of choosen type" do

      fuels = Fuel.all
      sorted_fuel = Fuel.sort_fuel_by_type(fuels,2)

        expect(sorted_fuel.count).to eq(1)      
        expect(sorted_fuel[0].fuel_type_id).to eq(2)
    end
  end

  describe "#find_fuels_by_month" do
    it "should return an array with medium resale prices organized by fuel type" do

      fuels = Fuel.all()

      fuels_type_array = Fuel.find_fuels_by_month(fuels)

      expect(fuels_type_array.count).to eq(12)

    end
  end

  describe "#find_fuels_by_month" do
    it "should return an array with medium resale prices organized by gasoline, diesel and ethanol" do

      fuels = Fuel.all()

      fuels_type_array = Fuel.find_fuels_by_month(fuels)

      expect(fuels_type_array[1]["GASOLINE"].count).to eq(1)
      expect(fuels_type_array[1]["DIESEL"].count).to eq(1)
      expect(fuels_type_array[1]["ETHANOL"].count).to eq(1)

    end
  end

  describe "#find_all_fuels_of_county_of_selected_year comparing by array size" do
    it "should return an array with fuels by year selected" do

      researches = FuelResearch.all()

      fuels_selected_year_2015 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2015")
      fuels_selected_year_2016 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2016")
      fuels_selected_year_2013 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2013")

      expect(fuels_selected_year_2015.count).to eq(1)
      expect(fuels_selected_year_2016.count).to eq(1)
      expect(fuels_selected_year_2013.count).to eq(0)

    end
  end

  describe "#find_all_fuels_of_county_of_selected_year comparing array in array size" do
    it "should return an array with fuels by year selected" do

      researches = FuelResearch.all()

      fuels_selected_year_2015 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2015")
      fuels_selected_year_2016 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2016")

      expect(fuels_selected_year_2015[0].count).to eq(2)
      expect(fuels_selected_year_2016[0].count).to eq(1)

    end
  end

  describe "#find_all_fuels_of_county_of_selected_year comparing by id" do
    it "should return an array with fuels by year selected" do

      researches = FuelResearch.all()

      fuels_selected_year_2015 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2015")
      fuels_selected_year_2016 = Fuel.find_all_fuels_of_county_of_selected_year(researches, "2016")

      expect(fuels_selected_year_2015[0][0].id).to eq(1)
      expect(fuels_selected_year_2015[0][1].id).to eq(2)
      expect(fuels_selected_year_2016[0][0].id).to eq(3)

    end
  end

end
