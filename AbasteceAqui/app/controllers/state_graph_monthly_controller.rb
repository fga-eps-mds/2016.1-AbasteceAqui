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
			all_medias = get_monthly_state_fuel_media(state_searched, year_searched)
			@chart = generate_monthly_graph_by_state(all_medias, state_searched, year_searched)
		else
			# do nothing
		end

	end

	# get all states from db
	# needed at view to generate states dropdown
	# return a state array with all states
	def get_all_states()

		states  = State.get_state_names()

		return states

	end

	# get all years from db
	# needed at view to generate years dropdown
	# return a years array with all years that we have at db
	def get_all_years_from_researches()

		all_researches = FuelResearch.find_all_researches()
		years = FuelResearch.find_years_of_researches(all_researches)

		return years

	end

	# generate the chart of state monthly
	def generate_monthly_graph_by_state(all_medias, state_searched, year_searched)

		title = "Preço do combustivel no decorrer do ano - #{state_searched} #{year_searched}"

		return generate_graph(all_medias[0], all_medias[1], all_medias[2], title)

	end

	# get all monthly media of the states
	def get_monthly_state_fuel_media(state, year)

		researches_of_year = find_researches_of_year(state, year)

		fuels = separete_fuels_of_researches(researches_of_year)

		all_medias = calculate_media(fuels)

		return all_medias

	end

	# find all researches of an year of a state
	def find_researches_of_year(state, year)

		counties = State.search_state_counties_by_object(state)
		counties_year_researches = State.find_all_researches_of_counties_by_year(counties, year)

		return counties_year_researches

	end

	# create fuels hash
	def create_fuels_hash

		# fuels == {
		# 	1 => ['ethanol data for month 1']['gas data month 1']['disel data month 1']
		# 	2 => ['ethanol data for month 2']['gas data month 2']['disel data month 2']
		# 	3 => [][][]
		# 	4 => [][][]
		# 		...
		# }

		fuels = Hash.new

		(1..12).each do |month|

			gas = []
			diesel = []
			ethanol = []
			fuels[month] = [ethanol, gas, diesel]

		end

		return fuels

	end

	# fill fuels hash
	def separete_fuels_of_researches(researches_of_year)

		fuels = create_fuels_hash()

		researches_of_year.each do |research|
			separete_prices_by_fuel_type(fuels, research)
		end

		return fuels

	end

	def separete_prices_by_fuel_type(fuels, research)

		research.fuels.each do |f|
			if f.medium_resale_price != 0.0
				add_medium_resale_price_to_its_fuels(f, fuels, research)
			else
				# do nothing
			end

		end

	end

	def add_medium_resale_price_to_its_fuels(f, fuels, research)

		if f.fuel_type_id == 1
			fuels[research.date.month][0] << f.medium_resale_price
		elsif f.fuel_type_id == 2
			fuels[research.date.month][1] << f.medium_resale_price
		elsif f.fuel_type_id == 5
			fuels[research.date.month][2] << f.medium_resale_price
		end

	end


	# calculate media for each month of each fuel
	def calculate_media(fuels)

		ethanol_media = []
		gas_media = []
		diesel_media = []

		fuels.each do |month, f|

			ethanol_media << (f[0].sum / f[0].size.to_f).round(3)
			gas_media << (f[1].sum / f[1].size.to_f).round(3)
			diesel_media << (f[2].sum / f[2].size.to_f).round(3)

		end

		all_medias = [gas_media, ethanol_media, diesel_media]

		return all_medias

	end

end
