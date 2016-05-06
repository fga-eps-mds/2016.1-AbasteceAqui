class SearchController < ApplicationController

	def index

		find_states()
		@state_searched = params[:state_searched]
		find_counties_of_state()
		@county_searched = params[:county_searched]

	end

	def find_states

		@states = State.fill_states
		
	end

	def find_counties_of_state
		
		@counties_of_state = State.search_state_counties(@state_searched)

	end

	def search_state

	end

end