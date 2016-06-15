class State < ActiveRecord::Base

	belongs_to :region
	has_many :counties


	def self.fill_states

		fill_object_states()
		@states_name = []

		@object_states.each do |state|
			@states_name << state.name
		end

		return @states_name.sort!

	end

	def self.fill_object_states


		@object_states = State.all

	end

	def self.search_state_counties(state_searched, type = "name")

		state_counties = State.find_by(name: state_searched).counties

		counties_of_state = []

		state_counties.each do |counties|
			if (type == "name")
				counties_of_state << counties.name
			elsif (type == "object")
				counties_of_state << counties
			else
				#do nothing
			end
		end

		return counties_of_state

	end

	# find researches of an year for all counties
	def self.find_all_conty_year_researches(state, year)

		counties = State.search_state_counties(state, "object")
		counties_year_researches = []


		counties.each do |county|

			research = County.researches_of_year(county, year)

			counties_year_researches += research

		end

		return counties_year_researches

	end

end
