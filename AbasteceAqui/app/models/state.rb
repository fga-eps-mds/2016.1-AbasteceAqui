class State < ActiveRecord::Base
	
	belongs_to :region
	has_many :counties

	def fill_states

		@object_states = State.all

	end

	def initialize

		@state_searched = "Digite o estado"
		@states = []

		@object_states.each do |state|
			@states << state.name
		end

	end

	def seach_state_id

		@state_id = Hash.new

		@object_states.each do |state|
			if state.name == @state_searched
				@state_id[@state_searched] = state.id
			end
		end

	end

end
