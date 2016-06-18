class State < ActiveRecord::Base

	belongs_to :region
	has_many :counties

	# this method fill the array with all states name of database
	def self.get_state_names

		get_state_objects()
		@states_name = []

		@object_states.each do |state|
			@states_name << state.name
		end

		return @states_name.sort!

	end

	# this method fill the array with all state objects of database
	def self.get_state_objects


		@object_states = State.all

	end

	# this method fill the array with all counties objects of selected state
	def self.search_state_counties_by_object(state_searched)

		state_counties = State.find_by(name: state_searched).counties

		counties_of_state = []

		state_counties.each do |counties|
			counties_of_state << counties
		end

		return counties_of_state

	end

	# this method fill the array with all counties' name of selected state
	def self.search_state_counties_by_name(state_searched)

		state_counties = State.find_by(name: state_searched).counties

		counties_of_state = []

		state_counties.each do |counties|
			counties_of_state << counties.name
		end

		return counties_of_state

	end

	# metodo deve estar em fuel researches
	# find researches of an year for all counties
	def self.find_all_researches_of_counties_by_year(counties, year)

		counties_year_researches = []


		counties.each do |county|

			research = County.researches_of_year(county, year)
			counties_year_researches += research

		end

		return counties_year_researches

	end

end
