require "rails_helper"

RSpec.describe FuelType, type: :model do 

	before do

		fuel_type = FuelType.new(id: 1, type_name: "GASOLINE")
		fuel_type.save

		fuel1 = Fuel.new(id: 1, number_of_gas_station: 42, 
					min_resale_price: 2.999, medium_resale_price: 3.087, 
					max_resale_price: 3.199, resale_standard_deviation: 0.044, 
					min_distribuition_price: 2.67, medium_distribuition_price: 2.783,
					max_distribuition_price: 2.863, distribuition_standard_deviation: 0.057,
					 fuel_research_id: 1517, fuel_type_id: 1)

		fuel2 = Fuel.new(id: 2, number_of_gas_station: 42, 
					min_resale_price: 2.999, medium_resale_price: 3.087, 
					max_resale_price: 3.199, resale_standard_deviation: 0.044, 
					min_distribuition_price: 2.67, medium_distribuition_price: 2.783,
					max_distribuition_price: 2.863, distribuition_standard_deviation: 0.057,
					 fuel_research_id: 1517, fuel_type_id: 1)

		fuel1.save
		fuel2.save

	end


	describe "#new" do

		it "Should be a instance of FuelType" do

			fuels = FuelType.find(1).fuels

			expect(fuels.count).to eq(2)

		end

	end

end