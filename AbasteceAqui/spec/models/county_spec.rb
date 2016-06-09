require "rails_helper"

RSpec.describe County, type: :model do

	before do

		county1 = County.new(id: 1, name: "ABAETETUBA", state_id: 1)
		county2 = County.new(id: 2, name: "BRASILIA")
		fuel_research1 = FuelResearch.new(id: 1, date: "2016-01-01", county_id: 1)
		fuel_research2 = FuelResearch.new(id: 2, date: "2016-02-01", county_id: 1)
		fuel_research3 = FuelResearch.new(id: 3, date: "2016-03-01", county_id: 1)

		@fuel1 = Fuel.new(id: 1, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.199,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 1, fuel_type_id: 1)
    @fuel2 = Fuel.new(id: 2, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.199,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 1, fuel_type_id: 2)

    @fuel3 = Fuel.new(id: 3, number_of_gas_station: 4,
         min_resale_price: 2.199, medium_resale_price: 2.199,
         max_resale_price: 2.199, resale_standard_deviation: 0.0,
         min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
         max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
         fuel_research_id: 2, fuel_type_id: 5)

		county1.save
		county2.save
		fuel_research1.save
		fuel_research2.save
		fuel_research3.save
		@fuel1.save
    @fuel2.save
    @fuel3.save

	end

	describe "#search_county_research" do
		it "Find last reserach equal 3" do

			last_research = County.search_county_research("ABAETETUBA")

			expect(last_research).to eq(3)

		end
	end

	describe "#fill_counties" do
		it "should returns all counties in database" do
			counties1 = County.all
			counties2 = County.fill_counties

			expect(counties1).to eq(counties2)
		end
	end

	describe "#fill_counties" do
		it "should returns all counties in database" do

			counties_fuels = []
			counties_fuels[0] = [@fuel1, @fuel2, @fuel3]
			counties_fuels[1] = [@fuel1, @fuel2, @fuel3]
			counties_fuels[2] = [@fuel1, @fuel2, @fuel3]

			sorted_counties = County.sort_counties_by_fuel_price(counties_fuels)
			expect(sorted_counties.count).to eq(3)
		end
	end


end
