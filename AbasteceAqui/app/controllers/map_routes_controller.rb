class MapRoutesController < ApplicationController

	def index

	end

	def index_database

		find_counties()
		find_last_research_of_counties(@counties)
		find_states()
		find_fuels_of_research(@researches)

	end

	def find_states

		@states = State.get_state_objects()

		return @states

	end

	def find_counties

		@counties = County.fill_counties()

		return @counties

	end

	def find_last_research_of_counties(counties)

		@researches = FuelResearch.fill_object_last_research(counties)

		return @researches

	end

	def find_fuels_of_research(researches)

		@fuels = Fuel.fuels_latest_researches_counties(researches)

		return @fuels

	end


end
