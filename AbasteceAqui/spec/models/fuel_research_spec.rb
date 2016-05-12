require "rails_helper"

RSpec.describe FuelResearch, type: :model do 

	before do
		
		fuel_research = FuelResearch.new(id: 1, date: "2016-02-01")
		fuel_research.save

		fuel1 = Fuel.new(id: 1, number_of_gas_station: 4,
				 min_resale_price: 2.199, medium_resale_price: 2.199, 
				 max_resale_price: 2.199, resale_standard_deviation: 0.0, 
				 min_distribuition_price: 0.0, medium_distribuition_price: 0.0, 
				 max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
				 fuel_research_id: 1, fuel_type_id: 6)
		fuel2 = Fuel.new(id: 2, number_of_gas_station: 4,
				 min_resale_price: 2.199, medium_resale_price: 2.199, 
				 max_resale_price: 2.199, resale_standard_deviation: 0.0, 
				 min_distribuition_price: 0.0, medium_distribuition_price: 0.0, 
				 max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
				 fuel_research_id: 1, fuel_type_id: 6)

		fuel1.save
		fuel2.save
	end

	describe "#search_fuel_research" do

		it "id equals 1" do
			arrayTeste = FuelResearch.search_fuels_research(1)

			expect(arrayTeste.count).to eq(2)
		end

	end

end