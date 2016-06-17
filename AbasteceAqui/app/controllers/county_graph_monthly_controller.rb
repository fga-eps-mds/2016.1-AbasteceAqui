class CountyGraphMonthlyController < ApplicationController

	def index

		find_all_states()
		if params[:states] != nil
			find_all_counties_of_state_searched(params[:states])
			find_all_researches_of_county(state_searched)
		else
			#do nothing
		end

		if params[:counties] != nil
			find_all_researches_of_county_searched(params[:counties])
			find_all_years_of_researches(@all_researches_of_county)
		else
			#do nothing
		end

		if params[:years] != nil
			find_all_fuels_of_county(@all_researches_of_county, params[:years])
			find_fuels_of_county_by_month(@all_fuels)
			sorting_fuels_of_county(@month_fuels)
			generate_monthly_graph_county(@sorted_fuels)
		else
			#do nothing
		end
		
	end

	def find_all_states()

		@states = States.fill_object_states()

		return @states

	end

	def find_all_counties_of_state_searched(state_searched)

		@counties_of_state = State.search_state_counties(state_searched, "object")

		return @counties_of_state

	end

	def find_all_researches_of_county_searched(county_searched)

		@all_researches_of_county = FuelResearch.find_all_researches_of_county(county_searched)

		return @all_researches_of_county

	end

	def find_all_years_of_researches(all_researches_of_county)

		@years = FuelResearch.find_years_of_researches(all_researches_of_county)

		return @years

	end

	def find_all_fuels_of_county(all_researches_of_county, year_searched)

		@all_fuels = Fuel.find_all_fuels_of_county_of_selected_year(all_researches_of_county, year_searched)

		return @all_fuels

	end

	def find_fuels_of_county_by_month(all_fuels)

		@month_fuels = Fuel.find_fuels_by_month(all_fuels)

		return @month_fuels

	end

	def sorting_fuels_of_county(month_fuels)

		@sorted_fuels = []

		for i in 0..(fuels_month.length-1)

			@sorted_fuels[0] << fuels_month[i]["GASOLINE"]
			@sorted_fuels[1] << fuels_month[i]["ETHANOL"]
			@sorted_fuels[2] << fuels_month[i]["DIESEL"]

		end

		return @sorted_fuels

	end

		#Generate the graph of county monthly
	def generate_monthly_graph_county(sorted_fuels)

		months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
					"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

		titulo = "Preço do combustivel no decorrer do ano - Brasil #{@year_searched}"

		@chart = LazyHighCharts::HighChart.new('graph') do |graph|
			graph.title(text:  titulo)
			graph.xAxis(categories: months)
			graph.series(name: "Preço Da Gasolina", yAxis: 0, data: sorted_fuels[0])
			graph.series(name: "Preço Do Etanol", yAxis: 0, data: sorted_fuels[1])
			graph.series(name: "Preço Do Diesel", yAxis: 0, data: sorted_fuels[2])

			graph.yAxis [
				{title: {text: "Preço Dos Combustíveis", margin: 70} },
			]

			graph.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
			graph.chart({defaultSeriesType: "line"})

		end

	end


end #end of class