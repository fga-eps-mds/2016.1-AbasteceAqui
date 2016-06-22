class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include ApplicationHelper

	# remove needless values from the given array
	# we use it to remove all nil values that we doesn't need at graph
	def remove_needless_values!(fuel)

		last_valid_value = 0

		for i in 0..11

			if fuel[i] != nil
				last_valid_value = i
			end

		end

		# remove all values from last_valid_value + 1 until the end o array
		fuel.slice!((last_valid_value + 1)..(fuel.length - 1))

	end

end
