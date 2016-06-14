class Fuel < ActiveRecord::Base

	belongs_to :fuel_research
	belongs_to :fuel_type

	def self.fuels_latest_researches_counties(researches)

		fuels = []

		for research in researches

			for fuel in research.fuels

				fuels << fuel

			end

		end

		return fuels
		
	end

	def self.verify_type_of_fuel(fuels, ethanol_prices, gas_prices, diesel_prices)
		fuels.each do |fuel|

			if fuel.fuel_type_id == 1
				ethanol_prices << fuel
			elsif fuel.fuel_type_id == 2
				gas_prices << fuel
			elsif fuel.fuel_type_id == 5
				diesel_prices << fuel
			end
		end
	end

		# This method calculates the average of the medium distribution of the type of fuel in question in relation to the 12 months of year
	def self.calculate_price_fuel(fuel_prices_month)
		sum_fuel = 0.0 # This variable holds the value of the sum of the type of fuel in question in relation to the 12 months of year
		number_of_prices_researches = 0.0 # this variable holds the division factor in relation to the months that do not have value 0
		total_of_the_month_county = 0.0
		total_of_the_month_state = 0.0
			
		fuel_prices_month.each do |fuel|
			sum_fuel = sum_fuel + fuel.medium_resale_price
			if fuel.medium_resale_price != 0.0
				number_of_prices_researches = number_of_prices_researches + 1
			end
		end

		total_of_the_year_state = (sum_fuel/number_of_prices_researches).round(3)
		#sum_fuel = 0.0 # This variable holds the value of the sum of the type of fuel in question in relation to the 12 months of year
		#number_of_prices_researches = 0.0 # this variable holds the division factor in relation to the months that do not have value 0


		#total_of_the_month_state = (total_of_the_month_state + total_of_the_month_county)
			
		#total_of_the_month_state = total_of_the_month_state/ @counties_of_state.length

		return total_of_the_year_state.round(3)
	end

end
