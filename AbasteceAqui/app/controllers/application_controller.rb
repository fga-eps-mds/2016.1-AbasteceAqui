class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include ApplicationHelper

	# calculate the averege of a fuel
	def calculate_average_of_fuel(fuels_month, fuel_name)

		average_of_fuel = []
		for i in 0..(fuels_month.length-1)

			average_of_fuel[i] = fuels_month[i][fuel_name].inject{|number_1,number_2| number_1 + number_2}
			if average_of_fuel[i] != nil
				average_of_fuel[i] = (average_of_fuel[i]/fuels_month[i][fuel_name].length).round(3)
			else
				#do nothing
			end

		end

		return average_of_fuel
	end

end
