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

			Fuel.verify_type_of_fuel(fuels, @ethanol_prices_month, @gas_prices_month, @diesel_prices_month)

			@gas_prices_for_year << Fuel.calculate_price_fuel(@gas_prices_month)
			@ethanol_prices_for_year << Fuel.calculate_price_fuel(@ethanol_prices_month)
			@diesel_prices_for_year << Fuel.calculate_price_fuel(@diesel_prices_month)

		end

		@total_price = [@gas_prices_for_year, @ethanol_prices_for_year, @diesel_prices_for_year]

		return @total_price
	end

end #end of class
