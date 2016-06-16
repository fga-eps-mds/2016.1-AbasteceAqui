require 'rails_helper'

RSpec.describe CountryGraphMonthlyController, type: :controller do

	before do

	    @fuel_research1 = FuelResearch.new(id: 1, date: "2015-04-01", county_id: 1)
	    @fuel_research2 = FuelResearch.new(id: 2, date: "2014-05-01", county_id: 1)
	    @fuel1 = Fuel.new(id: 1, medium_resale_price: 3.0, fuel_type_id: 1, fuel_research_id: 1)
	    @fuel2 = Fuel.new(id: 2, medium_resale_price: 5.0, fuel_type_id: 2, fuel_research_id: 1)
	    @fuel3 = Fuel.new(id: 3, medium_resale_price: 4.0, fuel_type_id: 5, fuel_research_id: 2)
	
		@fuel_research1.save
		@fuel_research2.save
		@fuel1.save
		@fuel2.save
		@fuel3.save

	end

	describe "#find_all_researches comparing array size" do
		it "should return all researches" do
			all_researches = controller.find_all_researches()

			expect(all_researches.count).to eq(2)
		end

	end

	describe "#find_all_researches comparing id" do
		it "should return all researches " do
			all_researches = controller.find_all_researches()

			expect(all_researches[0].id).to eq(1)
			expect(all_researches[1].id).to eq(2)
		end

	end


end