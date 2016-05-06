class SearchController < ApplicationController

	def index

		find_states()
		@state_searched = params[:state_searched]
		find_counties_of_state()
		@county_searched = params[:county_searched]
		find_researches_of_county()
		teste()

	end

	def find_states

		@states = State.fill_states
		
	end

	def find_counties_of_state
		
		@counties_of_state = State.search_state_counties(@state_searched)

	end

	def find_researches_of_county

		@last_research = County.search_county_research(@county_searched)

	end

	def teste
		@teste = FuelResearch.search_fuels_research(@last_research)
	end

	def search_state

	end

end