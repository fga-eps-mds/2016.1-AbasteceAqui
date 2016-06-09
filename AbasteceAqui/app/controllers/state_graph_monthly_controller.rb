class StateGraphMonthlyController < ApplicationController

	def state_monthly

		@states = State.fill_states
		@state_searched = params[:state_searched]

		if @state_searched != nil
			@counties_of_state = State.search_state_counties(@state_searched)
		else
			# do nothing
		end

		@county_searched = params[:county_searched]

		find_years()

	end

	def find_years

		@years = Set.new
		all_researches = FuelResearch.find_all_researches

		all_researches.each do |research|

			@years.add(research.date.year)

		end

		@years = @years.to_a

		return @years

	end


end