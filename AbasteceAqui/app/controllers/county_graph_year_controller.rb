class CountyGraphYearController < ApplicationController

	def index

		get_all_state_names()

		if params[:state_searched] != nil
			find_all_counties_of_state_searched(params[:state_searched])
		else
			# do nothing
		end

		if params[:county_searched] != nil
			find_all_researches_of_county_searched(params[:county_searched])
			find_all_years_of_researches(@all_researches_of_county)
			fuels_of_year(@years, @all_researches_of_county)
			find_all_fuels_of_county(@researches_of_year_separeted)
			get_prices_of_fuel(@all_fuels)

			@gas_price_averages = calculate_fuel_price_averages(@gas)
			@ethanol_price_averages = calculate_fuel_price_averages(@ethanol)
			@diesel_price_averages = calculate_fuel_price_averages(@diesel)

			generate_annual_graph_by_county(@diesel_price_averages, @ethanol_price_averages, @gas_price_averages, @years)

		else
			# do nothing
		end

	end

	def get_all_state_names()

		@states = State.get_state_names()

		return @states

	end

	def find_all_counties_of_state_searched(state_searched)

		@counties_of_state = State.search_state_counties_by_name(state_searched)

		return @counties_of_state

	end

	def find_all_researches_of_county_searched(county_searched)

		@all_researches_of_county = FuelResearch.find_all_researches_of_county(county_searched)

		return @all_researches_of_county

	end

	def find_all_years_of_researches(all_researches_of_county)

		@years = FuelResearch.find_years_of_researches(all_researches_of_county)

		return @years

	end

	def fuels_of_year(years, all_researches_of_county)

		@researches_of_year_separeted = Hash.new

		years.each do |year|

			@researches_of_year = FuelResearch.researches_of_year(year.to_s, all_researches_of_county)

			@researches_of_year_separeted[year.to_s] = @researches_of_year

		end

		return @researches_of_year_separeted
	end


	def find_all_fuels_of_county(researches_of_year_separeted)

		@all_fuels = Hash.new

		researches_of_year_separeted.each do |years, all_year_researches_of_county|

			@all_fuels[years] = []
			@all_fuels[years] += Fuel.get_fuels_of_researchs(all_year_researches_of_county)

		end

		return @all_fuels


	end


	def get_prices_of_fuel(all_fuels)

		@ethanol = Hash.new
		@gas = Hash.new
		@diesel = Hash.new

		all_fuels.each do |year, all_fuels_by_year|

			@ethanol[year] = []
			@gas[year] = []
			@diesel[year] = []

			Fuel.separate_fuels_by_type!(all_fuels_by_year, @ethanol[year], @gas[year], @diesel[year], "medium_resale_price")

		end

	end


	# recive a fuel and calculate the average price of a fuel in the years
	def calculate_fuel_price_averages(fuel)

		averages_price = []

		fuel.each do |year,fuel_of_year|
			if(fuel_of_year != [])
				averages_price << (fuel_of_year.inject{|number_1,number_2| number_1 + number_2}/fuel_of_year.length).round(3)
			end

		end

		return averages_price
	end


	def generate_annual_graph_by_county(diesel_price_averages, ethanol_price_averages, gas_price_averages, years)

		title = "Preço do combustivel no decorrer dos anos - #{params[:county_searched].titleize}"

		return generate_graph(gas_price_averages, ethanol_price_averages, diesel_price_averages, title,years)
	end

end #end of class
