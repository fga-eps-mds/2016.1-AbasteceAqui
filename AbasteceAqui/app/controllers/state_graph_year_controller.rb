class StateGraphYearController < ApplicationController

	def state_annual

		@states = State.fill_states
		@state_searched = params[:state_searched]

		if @state_searched != nil
			@counties_of_state = State.search_state_counties(@state_searched)
			generate_annual_graph_by_state()
		else
			# do nothing
		end

	end

	def generate_annual_graph_by_state

		@years = [2013, 2014, 2015]

		titulo = "Preço do combustível no decorrer dos anos"

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title(text:  titulo + " - " + @state_searched)
			f.xAxis(categories: @years)
			f.series(name: "Preço Da Gasolina", yAxis: 0, data: prices_of_fuel[0])
			f.series(name: "Preço Do Etanol", yAxis: 0, data: prices_of_fuel[1])
			f.series(name: "Preço Do Diesel", yAxis: 0, data: prices_of_fuel[2])

			f.yAxis [
				{title: {text: "Preço Dos Combustíveis", margin: 70} },

			]

			f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
			f.chart({defaultSeriesType: "line"})
		end
	end

	def verify_type_of_fuel(fuels, ethanol_prices, gas_prices, diesel_prices)
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

	def prices_of_fuel

		#These variables stores the three mediums prices of the three types of fuels.
		@gas_prices_for_year = [] #FuelType id: 2
		@ethanol_prices_for_year = [] #FuelType id: 1
		@diesel_prices_for_year = [] #FuelType id: 5

		fuels_of_year.each do |year, fuels|

			#These variables will store the fuels that equals to the type evidenced by the name of the vectors.
			@gas_prices_month = []
			@ethanol_prices_month = []
			@diesel_prices_month =[]

			verify_type_of_fuel(fuels, @ethanol_prices_month, @gas_prices_month, @diesel_prices_month)

			@gas_prices_for_year << calculate_price_fuel(@gas_prices_month)
			@ethanol_prices_for_year << calculate_price_fuel(@ethanol_prices_month)
			@diesel_prices_for_year << calculate_price_fuel(@diesel_prices_month)

		end

		@total_price = [@gas_prices_for_year, @ethanol_prices_for_year, @diesel_prices_for_year]

		return @total_price
	end

	def fuels_of_year

		@years_of_fuels_state = Hash.new

		@years.each do |year|
			@years_of_fuels_state[year] = []

			@counties_of_state.each do |county|
				researches_of_county = County.find_by(name: county).fuel_researches
				check_year_of_research(researches_of_county, @years_of_fuels_state[year], year)
			end

		end

		return @years_of_fuels_state

	end

	def check_year_of_research(researches_of_county, researches_of_year, year)
		researches_of_county.each do |research|

			if research.date.strftime("%Y").to_i == year

				research.fuels.each do |fuel|
					researches_of_year << fuel
				end
			end
		end
	end

	# This method calculates the average of the medium distribution of the type of fuel in question in relation to the 12 months of year
	def calculate_price_fuel(fuel_prices_month)
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

end #end of class
