class StateGraphYearController < ApplicationController

	def state_annual

		@states = State.get_state_names()
		@state_searched = params[:state_searched]

		if @state_searched != nil
			@counties_of_state = State.search_state_counties_by_name(@state_searched)
			generate_annual_graph_by_state()
		else
			# do nothing
		end

	end

	def generate_annual_graph_by_state

		@years = [2013, 2014, 2015]

		title = "Preço do combustível no decorrer dos anos"

		return generate_graph(prices_of_fuel[0], prices_of_fuel[1], prices_of_fuel[2], title, @years)

	end


	def prices_of_fuel

		#These variables stores the three mediums prices of the three types of fuels.
		@gas_prices_for_year = [] #FuelType id: 2
		@ethanol_prices_for_year = [] #FuelType id: 1
		@diesel_prices_for_year = [] #FuelType id: 5

		County.fuels_of_year(@years, @counties_of_state).each do |year, fuels|

			#These variables will store the fuels that equals to the type evidenced by the name of the vectors.
			@gas_prices_month = []
			@ethanol_prices_month = []
			@diesel_prices_month =[]

			Fuel.separate_fuels_by_type!(fuels, @ethanol_prices_month, @gas_prices_month, @diesel_prices_month)

			@gas_prices_for_year << Fuel.calculate_price_fuel(@gas_prices_month)
			@ethanol_prices_for_year << Fuel.calculate_price_fuel(@ethanol_prices_month)
			@diesel_prices_for_year << Fuel.calculate_price_fuel(@diesel_prices_month)

		end

		@total_price = [@gas_prices_for_year, @ethanol_prices_for_year, @diesel_prices_for_year]

		return @total_price
	end

end #end of class
