class State < ActiveRecord::Base
	
	belongs_to :region
	has_many :counties

	def initialize

		@states_name = []

	end

	def self.fill_states

		fill_object_states()

		@object_states.each do |state|
			@states_name << state.name
		end

		return @states_name.sort!

	end

	def fill_object_states

		@object_states = State.all

	end

	def self.search_state_counties(state_searched)

		state_counties = State.find_by(name: state_searched).counties

		counties_of_state = []

		state_counties.each do |counties|
			counties_of_state = counties.name
		end

		counties_of_state.sort!

		return counties_of_state

	end

end
