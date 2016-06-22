class CountryGraphMonthlyController < ApplicationController

	# method that render CountryGraphMonthlyController's view
	def index

		find_all_researches()
		find_all_years(@all_researches)

		@year_searched = params[:years]
		if @year_searched != nil
			find_researches_of_selected_year(@year_searched, @all_researches)
			find_fuels_of_research_of_year(@researches_of_year)
			find_fuels_by_type(@fuels)

			@average_gasoline = calculate_average_of_fuel(@fuels_month, "GASOLINE")
			@average_ethanol = calculate_average_of_fuel(@fuels_month, "ETHANOL")
			@average_diesel = calculate_average_of_fuel(@fuels_month, "DIESEL")

			generate_monthly_graph_country(@average_gasoline, @average_ethanol, @average_diesel)
		end

	end

	# find all researches in our database
	def find_all_researches()

		@all_researches = FuelResearch.find_all_researches()

		return @all_researches

	end

	# receive a research array and find all years of that researches
	def find_all_years(researches)

		@years = FuelResearch.find_years_of_researches(researches)

		return @years

	end

	# receive the selected year and an array with all researches
	# find the researches of selected year
	def find_researches_of_selected_year(selected_year, all_researches)

		@researches_of_year = FuelResearch.researches_of_year(selected_year, all_researches)

		return @researches_of_year
	end

	# receive an array with all researches of a year
	# returns all fuels of that year
	def find_fuels_of_research_of_year(researches_of_year)

		@fuels = Fuel.get_fuels_of_researchs(researches_of_year)

		return @fuels

	end

	# find fuels(gasoline, ethanol, diesel) of the researches of year selected
	def find_fuels_by_type(fuels)

		@fuels_month = Fuel.find_fuels_by_month(fuels)

		return @fuels_month

	end

	# generate the graph of country monthly
	def generate_monthly_graph_country(average_gasoline, average_ethanol, average_diesel)

		title = "Preço do combustivel no decorrer do ano - Brasil #{@year_searched}"
		return generate_graph(average_gasoline, average_ethanol, average_diesel, title)

	end

end
