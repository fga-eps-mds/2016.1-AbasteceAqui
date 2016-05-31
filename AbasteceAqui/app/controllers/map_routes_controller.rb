class MapRoutesController < ApplicationController

	def index

	end
	
	def find_counties

		@counties = County.fill_counties

		return @counties

	end

	def find_last_research_of_counties

		@researches = []

		for county in @counties
			@researches << FuelResearch.search_fuels_research(county)
		end

		return @researches

	end

	def find_fuels_of_research

		find_counties()
		find_last_research_of_counties()

		@fuels = []

		for research in @researches

			for fuel in research

				name = fuel.fuel_type.type_name
				fuel_hash = Hash.new
				fuel_hash[name] = research
				@fuels << fuel_hash

			end

		end

		return @fuels

	end


end