class SearchController < ApplicationController

	def index

		find_states()
		@state_searched = params[:state_searched]
		find_counties_of_state(@state_searched)
		@county_searched = params[:county_searched]
		if @county_searched != "Selecione um município" || @county_searched != nil
			find_researches_of_county(@county_searched)
			find_date_last_research(@id_last_research, @county_searched)
			search_fuels_last_research(@id_last_research, @county_searched)
		else
			# do nothing

		end

	end

	def map_brazil
		render :_map
	end

	def find_states

		@states = State.get_state_names

	end

	def find_counties_of_state(state_searched)

		@counties_of_state = State.search_state_counties_by_name(state_searched)

	end

	def find_researches_of_county(county_searched)

		@id_last_research = County.search_county_research(county_searched)

	end

	def find_date_last_research(id_last_research, county_searched)

		if county_searched != nil
			@date = FuelResearch.find_by(id: id_last_research).date
		else
			#do nothing
		end

	end

	def search_fuels_last_research(id_last_research, county_searched)

		if county_searched != nil
			@fuel = FuelResearch.search_fuels_research(id_last_research)
		else
			#do nothing
		end

	end

end
