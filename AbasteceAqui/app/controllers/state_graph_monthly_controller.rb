class StateGraphMonthlyController < ApplicationController

	# index page
	def state_monthly()

		@states = get_all_states()
		@years = get_all_years_from_researches()

		state_searched = params[:state_searched]
		year_searched = params[:years]

		# convert year_searched string to int, if it's nil  it become 0
		year_searched = year_searched.to_i()

		if year_searched != 0
			researches_of_year = find_researches_of_year(state_searched, year_searched)
			fuels = get_fuels_of_researches(researches_of_year)
			fuels_month = separate_fuels_by_month(fuels)
			average_gasoline = calculate_average_of_fuel(fuels_month, "GASOLINE")
			average_ethanol = calculate_average_of_fuel(fuels_month, "ETHANOL")
			average_diesel = calculate_average_of_fuel(fuels_month, "DIESEL")
			generate_monthly_graph_by_state(average_ethanol, average_gasoline, average_diesel, state_searched, year_searched)
		else
			# do nothing
		end

	end

	# get all years from db
	# needed at view to generate years dropdown
	# return a years array with all years that we have at db
	def get_all_years_from_researches()

		all_researches = FuelResearch.find_all_researches()
		years = FuelResearch.find_years_of_researches(all_researches)

		return years

	end

	# find all researches of an year of a state
	def find_researches_of_year(state, year)

		counties = State.search_state_counties_by_object(state)
		counties_year_researches = State.find_all_researches_of_counties_by_year(counties, year)

		return counties_year_researches

	end

	# get all fuels of researches year of a state
	def get_fuels_of_researches(researches_of_year)

		fuels = Fuel.get_fuels_of_researchs(researches_of_year)
		puts fuels
		return fuels

	end

	# separate all fuels found in months hash of name of fuel
	def separate_fuels_by_month(fuels)

		fuels_month = Fuel.find_fuels_by_month(fuels)
		return fuels_month

	end

	# generate the chart of state monthly
	def generate_monthly_graph_by_state(ethanol_media, gas_media, diesel_media, state_searched, year_searched)

		title = "Preço do combustivel no decorrer do ano - #{state_searched.titleize}, #{year_searched}"

		return generate_graph(gas_media, ethanol_media, diesel_media, title)

	end

end
