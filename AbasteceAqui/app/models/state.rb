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
				puts "invalid type"
			end
		end

		return counties_of_state

	end
end
