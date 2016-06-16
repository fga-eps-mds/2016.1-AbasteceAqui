class CountryGraphMonthlyController < ApplicationController

	def index

	end

	def find_all_researches()

		@all_researches = FuelResearch.find_all_researches()

		return @all_researches

	end

	def find_reserches_of_selected_year(selected_year, all_researches)

		@researches_of_year = FuelResearch.fuels_of_year_by_month(selected_year, all_researches)

		return @researches_of_year
	end

	def find_fuels_of_research_of_year(researches_of_year)

		@fuels = Fuel.fuels_latest_researches_counties(researches_of_year)

		return @fuels

	end

	def find_fuels_by_type(fuels)

		@gasoline = []
		@ethanol = []
		@diesel = []

		Fuel.verify_type_of_fuel(fuels, @gasoline, @ethanol, @diesel)

	end

end