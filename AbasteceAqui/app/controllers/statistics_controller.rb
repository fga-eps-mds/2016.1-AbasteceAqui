class StatisticsController < ApplicationController
  
  def index

  end

	def county_anual
	
		@states = State.fill_states
		@state_searched = "no option"
		@state_searched = params[:state_searched]

		@SearchController = SearchController.new

		if @state_searched != nil
			@counties_of_state = State.search_state_counties(@state_searched)
		else
			@state_searched = 'ACRE' 
			@counties_of_state = @SearchController.find_counties_of_state(@state_searched)
		end

		@county_searched = 'SENA MADUREIRA'
		@years = [2013, 2014, 2015]

		titulo = "Preço do combustivel no decorrer dos anos"

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
		  f.title(text:  titulo)
		  f.xAxis(categories: @years)
		  f.series(name: "Preço Da Gasolina", yAxis: 0, data: prices_of_fuel[0])
		  f.series(name: "Preço Do Etanol", yAxis: 0, data: prices_of_fuel[1])
		  f.series(name: "Preço Do Diesel", yAxis: 0, data: prices_of_fuel[2])

		  f.yAxis [
		    {title: {text: "Preço Da Gasolina", margin: 70} },
		    #{title: {text: "Preço Da Etanol", margin: 70} },
		   # {title: {text: "Preço Do Diesel", margin: 70} },

		  ]

		  f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
		  f.chart({defaultSeriesType: "line"})
		 end

		 prices_of_fuel()

			
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
	
	@gas_prices = [] #FuelType id: 2
	@ethanol_prices = [] #FuelType id: 1 
	@diesel_prices = [] #FuelType id: 5

	fuels_of_year.each do |year, fuels|

		@gas_prices_month = []
		@ethanol_prices_month = []
		@diesel_prices_month =[]

		gas_price_div = 0.0
		diesel_price_div = 0.0
		ethanol_price_div = 0.0
		

		fuels.each do |fuel|

			if fuel.fuel_type_id == 1
				@ethanol_prices_month << fuel
			elsif fuel.fuel_type_id == 2
				@gas_prices_month << fuel 
			elsif fuel.fuel_type_id == 5
				@diesel_prices_month << fuel
			end
		end

		sum_gas = 0.0
		@gas_prices_month.each do |fuel|
			sum_gas = sum_gas + fuel.medium_distribuition_price
			if fuel.medium_distribuition_price != 0.0
				gas_price_div = gas_price_div + 1
			end
		end

		sum_ethanol = 0.0
		@ethanol_prices_month.each do |fuel|
			sum_ethanol = sum_ethanol + fuel.medium_distribuition_price
			if fuel.medium_distribuition_price != 0.0
				ethanol_price_div = ethanol_price_div + 1
			end
		end

		sum_diesel = 0.0
		@diesel_prices_month.each do |fuel|
			sum_diesel = sum_diesel + fuel.medium_distribuition_price
			if fuel.medium_distribuition_price != 0.0
				diesel_price_div = diesel_price_div + 1
			end
		end

		@gas_prices << sum_gas / gas_price_div
		@ethanol_prices << sum_ethanol / ethanol_price_div
		@diesel_prices << sum_diesel / diesel_price_div


	end

	 

	@total_price = [@gas_prices, @ethanol_prices, @diesel_prices]

	return @total_price 
end

end
