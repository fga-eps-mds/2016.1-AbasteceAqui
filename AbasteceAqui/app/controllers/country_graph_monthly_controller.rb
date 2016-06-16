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

		@fuels_month = Fuel.find_fuels_by_month(fuels)

	end

	def calculate_average_of_gasoline(fuels_month)

		@average_gasoline = []

		fuels_month.each do |fuel_month|

			@average_gasoline << fuel_month["GASOLINE"].inject{|number_1, number_2| number_1 + number_2}

		end

		return @average_gasoline

	end

	def calculate_average_of_ethanol(fuels_month)

		@average_ethanol = []

		fuels_month.each do |fuel_month|

			@average_ethanol << sum(fuel_month["ETHANOL"].inject{|number_1, number_2| number_1 + number_2}
			
		end

		return @average_ethanol

	end

	def calculate_average_of_diesel(fuels_month)

		@average_diesel = []

		fuels_month.each do |fuel_month|

			@average_diesel << sum(fuel_month["DIESEL"].inject{|number_1, number_2| number_1 + number_2}
			
		end

		return @average_diesel

	end

end