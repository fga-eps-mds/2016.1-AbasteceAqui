class Fuel < ActiveRecord::Base

belongs_to :fuel_research
belongs_to :fuel_type
delegate :date,  :to => :fuel_research, :prefix => true


	# receive a array of researches and return all fuels of each one
	def self.get_fuels_of_researchs(researches)

		fuels = []

		for research in researches

			for fuel in research.fuels

				fuels << fuel

			end

		end

		return fuels

	end

	# receive a fuels array and a fuel type
	# returns a sorted array of given type
	def self.sort_fuel_by_type(fuels, type)

		sorted_fuel = []

		fuels.each do |fuel|

			if fuel.fuel_type_id == type
				sorted_fuel << fuel
			else
				# do nothing
			end

		end

		sorted_fuel.sort_by! {|const_sort| const_sort.medium_resale_price}

		return sorted_fuel

	end

	# receive a fuels array and a fuel type
	# returns a sorted array with distribution standard deviation of given type
	def self.sort_fuel_by_standard_deviation(fuels, type)

		sorted_fuel = []

		fuels.each do |fuel|

			if(fuel.fuel_type_id == type && fuel.resale_standard_deviation != 0.0)
				sorted_fuel << fuel
			else
				# do nothing
			end

		end

		sorted_fuel.sort_by! {|const_sort| const_sort.resale_standard_deviation}

		return sorted_fuel

	end

	# receive a array of fuels and separate it by type
	def self.separate_fuels_by_type!(fuels, ethanol, gas, diesel, atribute_type = "none")

		fuels.each do |fuel|


			self.get_fuel(fuel,ethanol,atribute_type , 1)
			self.get_fuel(fuel, gas,atribute_type , 2)
			self.get_fuel(fuel, diesel,atribute_type, 5)

		end

	end

	def self.get_fuel(fuel, vector_fuels, atribute_type , type_fuel)

		if fuel.fuel_type_id == type_fuel && atribute_type == "none"
			vector_fuels << fuel

		elsif fuel.fuel_type_id == type_fuel
			vector_fuels << fuel.medium_resale_price

		else
			# do nothing
		end

		return vector_fuels

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

	# separate fuels by medium resale price by type and by month
	def self.find_fuels_by_month(fuels)

		fuels_month = self.create_struct_for_separetaded_fuels()

		fuels.each do |fuel|

			put_fuel_price_in_fuels_month!(fuels_month, fuel)

		end

		return fuels_month

	end

	# receive a fuel_month array and a fuel
	# separate that fuel to the right position
	def self.put_fuel_price_in_fuels_month!(fuels_month, fuel)

		fuel_type_id = fuel.fuel_type_id

		if fuel_type_id == 1

			fuels_month[fuel.fuel_research_date.month-1]["ETHANOL"] << fuel.medium_resale_price

		elsif fuel_type_id == 2

			fuels_month[fuel.fuel_research_date.month-1]["GASOLINE"] << fuel.medium_resale_price

		elsif fuel_type_id == 5

			fuels_month[fuel.fuel_research_date.month-1]["DIESEL"] << fuel.medium_resale_price

		end

		return fuels_month

	end

	# create a struct that can receive separatad fuels by type
	def self.create_struct_for_separetaded_fuels()

		months = []

		# months[] == [
		# 	1 = {"ETHANOL" => [...]},{"GASOLINE" => [...]},{"DIESEL" => [...]},
		# 	2 = {"ETHANOL" => [...]},{"GASOLINE" => [...]},{"DIESEL" => [...]},
		# 	3 = {"ETHANOL" => [...]},{"GASOLINE" => [...]},{"DIESEL" => [...]},
		# 	...
		# ]

		for i in (0..11)

			months[i] = Hash.new
			months[i]["ETHANOL"] = []
			months[i]["GASOLINE"] = []
			months[i]["DIESEL"] = []

		end

		return months
	end

end #end of class
