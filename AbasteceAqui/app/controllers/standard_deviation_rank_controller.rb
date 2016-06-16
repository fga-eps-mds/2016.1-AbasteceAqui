class StandardDeviationRankController < ApplicationController

	def index

	end

	def find_states

		states = States.fill_states()

		return states

	end

end
