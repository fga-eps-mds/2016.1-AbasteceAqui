class CountyGraphMonthlyController < ApplicationController

	# method that render CountyGraphMonthlyController's view
	def index

		find_all_states()
		if params[:state_searched] != "Selecione um Estado" && params[:state_searched] != nil
			find_all_counties_of_state_searched(params[:state_searched])
		else
			#do nothing
		end

		if params[:county_searched] != "Selecione um Município" && params[:county_searched] != nil
			find_all_researches_of_county_searched(params[:county_searched])
			find_all_years_of_researches(@all_researches_of_county)
		else
			#do nothing
		end

		if params[:year_selected] != "Selecione um ano" && params[:year_selected] != nil
			find_researches_of_selected_year(params[:year_selected], @all_researches_of_county)
			find_all_fuels_of_county(@researches_of_year)
			find_fuels_of_county_by_month(@all_fuels)
			sorting_gasoline_of_county(@month_fuels)
			sorting_ethanol_of_county(@month_fuels)
			sorting_diesel_of_county(@month_fuels)
			generate_monthly_graph_county(@sorted_gasoline_array, @sorted_ethanol_array, @sorted_diesel_array)
		else
			#do nothing
		end

	end

	# method that find all states of our database
	def find_all_states()

		@states = State.get_state_names()

		return @states

	end

	# receive state selected in the view
	# method that find all counties of state_searched
	def find_all_counties_of_state_searched(state_searched)

		@counties_of_state = State.search_state_counties_by_name(state_searched)

		return @counties_of_state

	end

	# receive county selected in the view
	# method that find all researches of county_searched
	def find_all_researches_of_county_searched(county_searched)

		@all_researches_of_county = FuelResearch.find_all_researches_of_county(county_searched)

		return @all_researches_of_county

	end

	# receive  all researches of county selected in the view
	# method that find all years of all researches of county searched
	def find_all_years_of_researches(all_researches_of_county)

		@years = FuelResearch.find_years_of_researches(all_researches_of_county)

		return @years

	end

	# receive the year selected in view, and all research of county selected
	# method that separete all researches by year of county_searched
	def find_researches_of_selected_year(selected_years,all_researches_of_county)

		@researches_of_year = FuelResearch.fuels_of_year_by_month(selected_years, all_researches_of_county)

		return @researches_of_year

	end

	# receive all researches of the year selected
	# find all fuels of selected year of county_searched
	def find_all_fuels_of_county(researches_of_year)

		@all_fuels = Fuel.get_fuels_of_researchs(researches_of_year)

		return @all_fuels

	end

	# receive all fuels of researches_of_year selected
	# separete the fuels found by month
	def find_fuels_of_county_by_month(all_fuels)

		@month_fuels = Fuel.find_fuels_by_month(all_fuels)

		return @month_fuels

	end

	# receive a array of hash(name of fuel as key) separeted by months
	# sorting gasoline hash in array
	def sorting_gasoline_of_county(fuels_month)

		@sorted_gasoline_array = []

		for i in 0..(fuels_month.length-1)

			if fuels_month[i]["GASOLINE"] != []
				@sorted_gasoline_array[i] = fuels_month[i]["GASOLINE"]
			else
				@sorted_gasoline_array[i] = nil
			end

		end

		@sorted_gasoline_array

	end

	# receive a array of hash(name of fuel as key) separeted by months
	# sorting ethanol hash in array
	def sorting_ethanol_of_county(fuels_month)

		@sorted_ethanol_array = []

		for i in 0..(fuels_month.length-1)

			if fuels_month[i]["ETHANOL"] != []
				@sorted_ethanol_array[i] = fuels_month[i]["ETHANOL"]
			else
				@sorted_ethanol_array[i] = nil
			end

		end

		@sorted_ethanol_array

	end

	# receive a array of hash(name of fuel as key) separeted by months
	# sorting diesel hash in array
	def sorting_diesel_of_county(fuels_month)

		@sorted_diesel_array = []

		for i in 0..(fuels_month.length-1)

			if fuels_month[i]["DIESEL"] != []
				@sorted_diesel_array[i] = fuels_month[i]["DIESEL"]
			else
				@sorted_diesel_array[i] = nil
			end

		end

		@sorted_diesel_array

	end

	#Generate the graph of county monthly
	def generate_monthly_graph_county(average_gasoline, average_ethanol, average_diesel)

		title = "Preço do combustivel no decorrer do ano de #{params[:year_selected]},
				#{params[:county_searched].titleize} - #{params[:state_searched].titleize}"

		return generate_graph(average_gasoline, average_ethanol, average_diesel, title)
	end

end #end of class
