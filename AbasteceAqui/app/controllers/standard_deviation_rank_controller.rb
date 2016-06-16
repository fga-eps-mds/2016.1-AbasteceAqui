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

	def find_last_research_of_counties(counties)

		researches = FuelResearch.fill_object_last_research(counties)

		return researches

	end

end
