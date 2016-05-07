require 'rails_helper'

RSpec.describe SearchController, type: :controller do

	before do

		state1 = State.new(id: 1, name: "PARA", region_id: 1)
		state2 = State.new(id: 2, name: "MARANHAO", region_id: 2)
		state3 = State.new(id: 3, name: "DISTRITO FEDERAL", region_id: 3);
		
		county1 = County.new(id: 1, name: "BRASILIA", state_id: 3)
		county2 = County.new(id: 2, name: "GAMA", state_id: 3)



		fuel_research1 = FuelResearch.new(id:1, date:"2016-01-01", county_id: 1)

		fuel1 = Fuel.new(id: 1, number_of_gas_station: 4, min_resale_price: 2.199, 
			medium_resale_price: 2.199, max_resale_price: 2.199, resale_standard_deviation: 0.0, 
			min_distribuition_price: 0.0, medium_distribuition_price: 0.0, max_distribuition_price: 0.0, 
			distribuition_standard_deviation: 0.0, fuel_research_id: 1, fuel_type_id: 6)





		state1.save
		state2.save
		state3.save

		county1.save
		county2.save

		fuel_research1.save

		fuel1.save

	end

  describe "#find_states" do
    it "Should be all states" do
      states = controller.find_states

      expect(states).to eql(["DISTRITO FEDERAL", "MARANHAO", "PARA"])
    end
  end


	

=begin

  describe "#find_counties_of_state" do

  	before do

  	get :index, {:state_searched => "DISTRITO FEDERAL", :county_searched => "GAMA"} 

  	end
  	it "Should be the counties of the state" do

   			state_searched = "DISTRITO FEDERAL"

   			counties_of_state = controller.find_counties_of_state #, {:state_searched => "DISTRITO FEDERAL"}
  			
   		expect(counties_of_state).to eql(["BRASILIA", "GAMA"])
  		
  		
  	end
  end
=end
	
	describe "#find_date_last_research" do
		it "Should return the last date research" do
			date = controller.find_date_last_research(1)
			expect(date.to_s).to eq("2016-01-01")
		end
	end

	describe "#search_fuels_last_research" do
		it "Should return one object of array" do
			fuel = controller.search_fuels_last_research(1)
			expect(fuel.count).to eq(1)
		end
	end
 

end