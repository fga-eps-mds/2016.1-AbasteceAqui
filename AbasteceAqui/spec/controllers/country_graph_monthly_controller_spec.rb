require 'rails_helper'

RSpec.describe CountryGraphMonthlyController, type: :controller do

	before do
	    fuel_research1 = FuelResearch.new(id: 1, date: "2015-04-01", county_id: 1)
	    fuel_research2 = FuelResearch.new(id: 2, date: "2014-05-01", county_id: 1)
	    fuel1 = Fuel.new(id: 1, medium_resale_price: 3.0, fuel_type_id: 1, fuel_research_id: 1)
	    fuel2 = Fuel.new(id: 2, medium_resale_price: 5.0, fuel_type_id: 2, fuel_research_id: 1)
			fuel3 = Fuel.new(id: 3, medium_resale_price: 6.0, fuel_type_id: 5, fuel_research_id: 1)
	    fuel4 = Fuel.new(id: 4, medium_resale_price: 4.0, fuel_type_id: 5, fuel_research_id: 2)

			fuel_research1.save
			fuel_research2.save
			fuel1.save
			fuel2.save
			fuel3.save
			fuel4.save
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
			all_researches_selected_year_2015 = controller.find_researches_of_selected_year("2015", all_researches)
			all_researches_selected_year_2014 = controller.find_researches_of_selected_year("2014", all_researches)

			expect(all_researches_selected_year_2015[0].id).to eq(1)
			expect(all_researches_selected_year_2014[0].id).to eq(2)
		end
	end

	describe "#find_fuels_of_researches_of_year comparing array size" do
		it "shold return fuels of selected year" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)

			expect(fuels.count).to eq(3)
		end
	end

	describe "#find_fuels_of_researches_of_year comparing id" do
		it "shold return fuels of selected year" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)

			expect(fuels[0].id).to eq(1)
			expect(fuels[1].id).to eq(2)
			expect(fuels[2].id).to eq(3)
		end
	end

	describe "#find_fuels_by_type comparing array size" do
		it "shold return all months, with gasoline, ethanol and diesel of selected year" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)

			expect(fuels_month.count).to eq(12)
		end
	end

	describe "#find_fuels_by_type comparing price" do
		it "shold return all months, with gasoline, ethanol and diesel of selected year" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)

			expect(fuels_month[0]["GASOLINE"]).to eq([])
			expect(fuels_month[0]["ETHANOL"]).to eq([])
			expect(fuels_month[0]["DIESEL"]).to eq([])

			expect(fuels_month[3]["GASOLINE"]).to eq([5.0])
			expect(fuels_month[3]["ETHANOL"]).to eq([3.0])
			expect(fuels_month[3]["DIESEL"]).to eq([6.0])
		end
	end

	describe "#calculate_average_of_gasoline comparing array size" do
		it "shold return gasoline separeted by month" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)
			average_gasoline = controller.calculate_average_of_gasoline(fuels_month)

			expect(average_gasoline.count).to eq(12)
		end
	end

	describe "#calculate_average_of_gasoline comparing array size" do
		it "shold return gasoline separeted by month" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)
			average_gasoline = controller.calculate_average_of_gasoline(fuels_month)

			expect(average_gasoline[0]).to eq(nil)
			expect(average_gasoline[3]).to eq(5.0)
		end
	end



	describe "#calculate_average_of_ethanol comparing average" do
		it "shold return ethanol separeted by month" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)
			average_ethanol = controller.calculate_average_of_ethanol(fuels_month)

			expect(average_ethanol.count).to eq(12)
		end
	end

	describe "#calculate_average_of_ethanol comparing average" do
		it "shold return ethanol separeted by month" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)
			average_ethanol = controller.calculate_average_of_ethanol(fuels_month)

			expect(average_ethanol[0]).to eq(nil)
			expect(average_ethanol[3]).to eq(3.0)
		end
	end

	describe "#calculate_average_of_diesel comparing array size" do
		it "shold return diesel separeted by month" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)
			average_diesel = controller.calculate_average_of_diesel(fuels_month)

			expect(average_diesel.count).to eq(12)
		end
	end

	describe "#calculate_average_of_diesel comparing average" do
		it "shold return diesel separeted by month" do
			all_researches = controller.find_all_researches()
			all_researches_selected_year = controller.find_researches_of_selected_year("2015", all_researches)
			fuels = controller.find_fuels_of_research_of_year(all_researches_selected_year)
			fuels_month = controller.find_fuels_by_type(fuels)
			average_diesel = controller.calculate_average_of_diesel(fuels_month)

			expect(average_diesel[0]).to eq(nil)
			expect(average_diesel[3]).to eq(6.0)
		end
	end

	describe "#index" do
		it "Should render country_graph_monthly page" do
			get :index, {:years => "2015"}

			expect(response).to have_http_status(:success)
		end
	end

end
