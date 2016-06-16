class StandardDeviationRankController < ApplicationController

	def index

		@states = find_states()
		@researches = find_last_research_of_counties

	end

	def self.find_states

		#states = State.fill_object_states()
		states = State.fill_states()

		return states

	end

	def fill_fuels_last_research(researches)

    @fuels = Fuel.fuels_latest_researches_counties(researches)

    return @fuels

  end

	def self.find_last_research_of_counties(counties)

		researches = FuelResearch.fill_object_last_research(counties)

		return researches

	end

end
