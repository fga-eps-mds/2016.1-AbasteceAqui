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

	describe "#find_all_years comparing array size" do
		it "should return all years" do
			all_researches = controller.find_all_researches()
			all_years = controller.find_all_years(all_researches)

			expect(all_years.count).to eq(2)

		end
	end

	describe "#find_all_years comparing years" do
		it "should return all years" do
			all_researches = controller.find_all_researches()
			all_years = controller.find_all_years(all_researches)

			expect(all_years[0]).to eq(2015)
			expect(all_years[1]).to eq(2014)

		end
	end

	describe "#find_researches_of_selected_year comparing array size" do
		it "shold return all researches of selected year" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)

			expect(all_researches_selected_year.count).to eq(1)

		end
	end

	describe "#find_researches_of_selected_year comparing id" do
		it "shold return all researches of selected year" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			expect(all_researches_selected_year[0].id).to eq(1)

			all_researches_selected_year = controller.find_researches_of_selected_year("2014", all_researches)
			expect(all_researches_selected_year[0].id).to eq(2)

		end
	end

end
