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
			calculate_average_of_gasoline(@fuels_month)
			calculate_average_of_ethanol(@fuels_month)
			calculate_average_of_diesel(@fuels_month)
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

		@researches_of_year = FuelResearch.fuels_of_year_by_month(selected_year, all_researches)

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

	# calculate the averege of gasoline
	def calculate_average_of_gasoline(fuels_month)

		@average_gasoline = []
		for i in 0..(fuels_month.length-1)

			@average_gasoline[i] = fuels_month[i]["GASOLINE"].inject{|number_1,number_2| number_1 + number_2}
			if @average_gasoline[i] != nil
				@average_gasoline[i] = (@average_gasoline[i]/fuels_month[i]["GASOLINE"].length).round(3)
			else
				#do nothing
			end

		end

		return @average_gasoline
	end

	# calculate the averege of ethanol
	def calculate_average_of_ethanol(fuels_month)

		@average_ethanol = []

		for i in 0..(fuels_month.length-1)

			@average_ethanol[i] = fuels_month[i]["ETHANOL"].inject{|number_1,number_2| number_1 + number_2}
			if @average_ethanol[i] != nil
				@average_ethanol[i] = (@average_ethanol[i]/fuels_month[i]["ETHANOL"].length).round(3)
			else
				#do nothing
			end
		end

		return @average_ethanol

	end

	# calculate the averege of diesel
	def calculate_average_of_diesel(fuels_month)

		@average_diesel = []

		for i in 0..(fuels_month.length-1)

			@average_diesel[i] = fuels_month[i]["DIESEL"].inject{|number_1,number_2| number_1 + number_2}
			if @average_diesel[i] != nil
				@average_diesel[i] = (@average_diesel[i]/fuels_month[i]["DIESEL"].length).round(3)
			else
				#do nothing
			end

		end

		return @average_diesel

	end

	# generate the graph of country monthly
	def generate_monthly_graph_country(average_gasoline, average_ethanol, average_diesel)

		title = "Preço do combustivel no decorrer do ano - Brasil #{@year_searched}"
		return generate_graph(average_gasoline, average_ethanol, average_diesel, title)

	end

end
