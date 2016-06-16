require "rails_helper"

RSpec.describe FuelResearch, type: :model do

	before do

		@county1 = County.new(id: 1, name: "BRASILIA")
		@county2= County.new(id: 2, name: "RIO DE JANEIRO")
		@county1.save
		@county2.save

		@fuel_research1 = FuelResearch.new(id: 1, date: "2015-02-01", county_id: 1)
		@fuel_research2 = FuelResearch.new(id: 2, date: "2016-02-01", county_id: 2)
		@fuel_research1.save
		@fuel_research2.save


		@fuel1 = Fuel.new(id: 1, number_of_gas_station: 4,
				 min_resale_price: 2.199, medium_resale_price: 2.199,
				 max_resale_price: 2.199, resale_standard_deviation: 0.0,
				 min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
				 max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
				 fuel_research_id: 1, fuel_type_id: 6)
		@fuel2 = Fuel.new(id: 2, number_of_gas_station: 4,
				 min_resale_price: 2.199, medium_resale_price: 2.199,
				 max_resale_price: 2.199, resale_standard_deviation: 0.0,
				 min_distribuition_price: 0.0, medium_distribuition_price: 0.0,
				 max_distribuition_price: 0.0, distribuition_standard_deviation: 0.0,
				 fuel_research_id: 1, fuel_type_id: 6)

		@fuel1.save
		@fuel2.save
	end

	describe "#search_fuel_research" do
		it "id equals 1" do
			arrayTeste = FuelResearch.search_fuels_research(1)

			expect(arrayTeste.count).to eq(2)
		end
	end

	describe "#fill_object_last_research" do
		it "should returns an array with 1 elements" do
			last_researches = FuelResearch.fill_object_last_research(County.all)

			expect(last_researches.count).to eq(2)
		end
	end

    describe "#check_year_of_research" do
      it "should return an array with 2 elelements, when the year of research = 2015" do
        researches_of_county = @county1.fuel_researches
        researches_of_year = []
  
  		FuelResearch.check_year_of_research(researches_of_county, researches_of_year, 2015)
  
        expect(researches_of_year.count).to eq(2)
      end
    end


	describe "#find_years_of_researches" do
		it "should the year of all researches" do
			
			researches = FuelResearch.all

			years = FuelResearch.find_years_of_researches(researches)

			expect(years).to eq([2015, 2016])
			
		end

	end

	describe "#fuels_of_year_by_month" do
		it "should return the researches of the selected year" do

			researches = FuelResearch.all
			year = 2015
			researches_year = FuelResearch.fuels_of_year_by_month(year,researches)

			expect(researches_year[0].id).to eq(1)
		end

	end

end
