class CountryGraphMonthlyController < ApplicationController

	def index

		find_all_researches()
		find_all_years(@all_researches)
		@year_searched = params[:years]
		if @year_searched != nil
			find_researches_of_selected_year(@year_searched, @all_researches)
			find_fuels_of_research_of_year(@researches_of_year)
			find_fuels_by_type(@fuels)
			calculate_average_of_gasoline(@fuels_month)
			calculate_average_of_ethanol(@fuels_month)
			calculate_average_of_diesel(@fuels_month)
			generate_monthly_graph_country(@average_gasoline, @average_ethanol, @average_diesel)
		end

	end

	#Find all researches in our database
	def find_all_researches()

		@all_researches = FuelResearch.find_all_researches()

		return @all_researches

	end

	def find_all_years(researches)

		@years = FuelResearch.find_years_of_researches(researches)

		return @years

	end

	#Find the researches of selected year
	def find_researches_of_selected_year(selected_year, all_researches)

		@researches_of_year = FuelResearch.fuels_of_year_by_month(selected_year, all_researches)

		return @researches_of_year
	end

	def find_fuels_of_research_of_year(researches_of_year)

		@fuels = Fuel.get_fuels_of_researchs(researches_of_year)

		return @fuels

	end

	#Find fuels(gasoline, ethanol, diesel) of the researches of year selected
	def find_fuels_by_type(fuels)

		@fuels_month = Fuel.find_fuels_by_month(fuels)

		return @fuels_month

	end

	#Calculate the averege of gasoline
	def calculate_average_of_gasoline(fuels_month)

		@average_gasoline = []
		for i in 0..(fuels_month.length-1)

			@average_gasoline[i] = fuels_month[i]["GASOLINE"].inject{|number_1,number_2| number_1 + number_2}
			if @average_gasoline[i] != nil
				@average_gasoline[i] = (@average_gasoline[i]/fuels_month[i]["GASOLINE"].length).round(3)
			else
				#do nothing
			end

		end

		return @average_gasoline
	end

	#Calculate the averege of ethanol
	def calculate_average_of_ethanol(fuels_month)

		@average_ethanol = []

		for i in 0..(fuels_month.length-1)

			@average_ethanol[i] = fuels_month[i]["ETHANOL"].inject{|number_1,number_2| number_1 + number_2}
			if @average_ethanol[i] != nil
				@average_ethanol[i] = (@average_ethanol[i]/fuels_month[i]["ETHANOL"].length).round(3)
			else
				#do nothing
			end
		end

		return @average_ethanol

	end

	#Calculate the averege of diesel
	def calculate_average_of_diesel(fuels_month)

		@average_diesel = []

		for i in 0..(fuels_month.length-1)

			@average_diesel[i] = fuels_month[i]["DIESEL"].inject{|number_1,number_2| number_1 + number_2}
			if @average_diesel[i] != nil
				@average_diesel[i] = (@average_diesel[i]/fuels_month[i]["DIESEL"].length).round(3)
			else
				#do nothing
			end

		end

		return @average_diesel

	end

	#Generate the graph of country monthly
	def generate_monthly_graph_country(average_gasoline, average_ethanol, average_diesel)

		months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
					"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

		titulo = "Preço do combustivel no decorrer do ano - Brasil #{@year_searched}"

		@chart = LazyHighCharts::HighChart.new('graph') do |graph|
			graph.title(text:  titulo)
			graph.xAxis(categories: months)
			graph.series(name: "Preço Da Gasolina", yAxis: 0, data: average_gasoline)
			graph.series(name: "Preço Do Etanol", yAxis: 0, data: average_ethanol)
			graph.series(name: "Preço Do Diesel", yAxis: 0, data: average_diesel)

			graph.yAxis [
				{title: {text: "Preço Dos Combustíveis", margin: 70} },
			]

			graph.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
			graph.chart({defaultSeriesType: "line"})

		end

	end

end
