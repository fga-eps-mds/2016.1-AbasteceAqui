class StandardDeviationRankController < ApplicationController

	def index

		@states = find_states()
		@researches = find_last_research_of_counties

	end

	def find_counties

		@counties = County.fill_counties()

		return @counties

	end

	def self.find_last_research_of_counties(counties)

		researches = FuelResearch.fill_object_last_research(counties)

		return researches

	end

	def fill_fuels_last_research(researches)

    @fuels = Fuel.fuels_latest_researches_counties(researches)

    return @fuels

  end

	def find_ethanol_fuels_sorted(fuels)

    @ethanol_sorted = Fuel.ethanol_sorted(fuels)

    return @ethanol_sorted
  end



end
