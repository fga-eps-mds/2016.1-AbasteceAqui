	class StatisticsController < ApplicationController

	def index
	end

	def county_anual

		@states = State.fill_states
		@state_searched = params[:state_searched]

		if @state_searched != nil
			@counties_of_state = State.search_state_counties(@state_searched)
		else
			# do nothing
		end

		@county_searched = params[:county_searched]

		if @county_searched != nil
		generate_annual_graph_by_county()
		else
			# do nothing
		end

	end

	def generate_annual_graph_by_county

		@years = [2013, 2014, 2015]

		titulo = "Preço do combustivel no decorrer dos anos"

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title(text:  titulo + " - " + @county_searched)
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

	def fuels_of_year

		@researches_of_county = County.find_by(name: @county_searched).fuel_researches
		@years_of_researches = Hash.new

		@years.each do |year|

			@years_of_researches[year] = Hash.new
			@researches_of_year = []

			@researches_of_county.each do |research|

				if research.date.strftime("%Y").to_i == year

					research.fuels.each do |fuel|
						@researches_of_year << fuel
					end
				end
			end

			@years_of_researches[year] = @researches_of_year

		end

		return @years_of_researches

	end

	def prices_of_fuel

	#These variables stores the three mediums prices of the three types of fuels.
	@gas_prices = [] #FuelType id: 2
	@ethanol_prices = [] #FuelType id: 1
	@diesel_prices = [] #FuelType id: 5

	fuels_of_year.each do |year, fuels|

		#These variables will store the fuels that equals to the type evidenced by the name of the vectors.
		@gas_prices_month = []
		@ethanol_prices_month = []
		@diesel_prices_month =[]

		fuels.each do |fuel|

			if fuel.fuel_type_id == 1
				@ethanol_prices_month << fuel
			elsif fuel.fuel_type_id == 2
				@gas_prices_month << fuel
			elsif fuel.fuel_type_id == 5
				@diesel_prices_month << fuel
			end
		end

		@gas_prices << calculate_price_fuel(@gas_prices_month)
		@ethanol_prices << calculate_price_fuel(@ethanol_prices_month)
		@diesel_prices << calculate_price_fuel(@diesel_prices_month)

	end

	@total_price = [@gas_prices, @ethanol_prices, @diesel_prices]

	return @total_price
end

# This method calculates the average of the medium distribution of the type of fuel in question in relation to the 12 months of year
def calculate_price_fuel(fuel_prices_month)
	sum_fuel = 0.0 # This variable holds the value of the sum of the type of fuel in question in relation to the 12 months of year
	fuel_price_div = 0.0 # this variable holds the division factor in relation to the months that do not have value 0

	fuel_prices_month.each do |fuel|
		sum_fuel = sum_fuel + fuel.medium_resale_price
		if fuel.medium_resale_price != 0.0
			fuel_price_div = fuel_price_div + 1
		end
	end

	return (sum_fuel/fuel_price_div).round(3)

end


end
