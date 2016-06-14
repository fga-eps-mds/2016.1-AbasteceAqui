require 'rails_helper'

RSpec.describe StateGraphYearController, type: :controller do

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

	describe "GET #state_annual" do
	    it "returns http success when state_searched != nil" do
	      get :state_annual, {:state_searched => @state1.name}
	      expect(response).to have_http_status(:success)
	    end

    end

    

=begin
	describe '#prices_of_fuel' do
		it "returns prices of fuel for state" do
			prices_total = StateGraphYear.prices_of_fuel
			#@counties_of_state = State.search_state_counties(@state1)
			ACRE_prices_2013 = [3.338, 2.821, 2.766]		

			expect(prices_total).to eq(ACRE_prices_2013)	
		end
	end
=end

end #end of class