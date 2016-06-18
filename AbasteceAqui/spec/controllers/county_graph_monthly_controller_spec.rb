require 'rails_helper'

RSpec.describe CountyGraphMonthlyController, type: :controller do

  before do
    state1 = State.new(id: 1, name:"DISTRITO FEDERAL")
    state2 = State.new(id:2, name:"RIO DE JANEIRO")
    state1.save
    state2.save

    county1 = County.new(id: 1, name: "BRASILIA", state_id: 1)
		county2= County.new(id: 2, name: "RIO DE JANEIRO", state_id:2)
		county1.save
		county2.save

		fuel_research1 = FuelResearch.new(id: 1, date: "2015-02-01", county_id: 1)
		fuel_research2 = FuelResearch.new(id: 2, date: "2016-02-01", county_id: 2)
		fuel_research1.save
		fuel_research2.save


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

  describe "#find_all_states comparing by array size" do
		it "should return all states of database" do

    	states= controller.find_all_states()

			expect(states.count).to eq(2)

		end
	end

  describe "#find_all_states comparing by name" do
		it "should return all states of database" do

    	states= controller.find_all_states()

			expect(states[0]).to eq("DISTRITO FEDERAL")
      expect(states[1]).to eq("RIO DE JANEIRO")

		end
	end


end
