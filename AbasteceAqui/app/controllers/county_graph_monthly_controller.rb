class CountyGraphMonthlyController < ApplicationController

	def index

	end

	def find_all_states()

		@states = States.fill_object_states()

		return @states

	end

	def find_all_counties_of_state_searched(state_searched)

		@counties_of_state = State.search_state_counties(state_searched, "object")

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

end #end of class