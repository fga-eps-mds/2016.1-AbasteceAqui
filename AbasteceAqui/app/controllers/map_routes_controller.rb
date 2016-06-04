class MapRoutesController < ApplicationController

	def index

	end

	def find_states 

		@states = State.fill_object_states()

		return @states

	end
	
	def find_counties

		@counties = County.fill_counties()

		return @counties

	end

	def find_last_research_of_counties

		@researches = FuelResearch.fill_object_last_research(@counties)

		return @researches

	end

	def find_fuels_of_research

		find_counties()
		find_last_research_of_counties()
		find_states()

		@fuels = Fuel.fuels_latest_researches_counties(@researches)

		return @fuels

	end


end