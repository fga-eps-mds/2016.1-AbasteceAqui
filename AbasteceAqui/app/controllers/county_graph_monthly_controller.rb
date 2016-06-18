class CountyGraphMonthlyController < ApplicationController

	def index

		find_all_states()
		if params[:state_searched] != "Selecione um Estado" && params[:state_searched] != nil
			find_all_counties_of_state_searched(params[:state_searched])
		else
			#do nothing
		end

		if params[:county_searched] != "Selecione um Município" && params[:county_searched] != nil
			find_all_researches_of_county_searched(params[:county_searched])
			find_all_years_of_researches(@all_researches_of_county)
		else
			#do nothing
		end

		if params[:year_selected] != "Selecione um ano" && params[:year_selected] != nil
			find_researches_of_selected_year(params[:year_selected], @all_researches_of_county)
			find_all_fuels_of_county(@researches_of_year)
			find_fuels_of_county_by_month(@all_fuels)
			sorting_gasoline_of_county(@month_fuels)
			sorting_ethanol_of_county(@month_fuels)
			sorting_diesel_of_county(@month_fuels)
			generate_monthly_graph_county(@sorted_gasoline_array, @sorted_ethanol_array, @sorted_diesel_array)
		else
			#do nothing
		end

	end

	def find_all_states()

		@states = State.get_state_names()

		return @states

	end

	def find_all_counties_of_state_searched(state_searched)

		@counties_of_state = State.search_state_counties_by_name(state_searched)

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
	
	def find_researches_of_selected_year(selected_years,all_researches_of_county)

		@researches_of_year = FuelResearch.fuels_of_year_by_month(selected_years, all_researches_of_county)

		return @researches_of_year

	end

	def find_all_fuels_of_county(researches_of_year)

		@all_fuels = Fuel.fuels_latest_researches_counties(researches_of_year)

		return @all_fuels

	end

	def find_fuels_of_county_by_month(all_fuels)

		@month_fuels = Fuel.find_fuels_by_month(all_fuels)

		return @month_fuels

	end

	def sorting_gasoline_of_county(fuels_month)

		@sorted_gasoline_array = []

		for i in 0..(fuels_month.length-1)

			if fuels_month[i]["GASOLINE"] != []
				@sorted_gasoline_array[i] = fuels_month[i]["GASOLINE"]
			else
				@sorted_gasoline_array[i] = nil
			end

		end

		@sorted_gasoline_array

	end

	def sorting_ethanol_of_county(fuels_month)

		@sorted_ethanol_array = []

		for i in 0..(fuels_month.length-1)

			if fuels_month[i]["ETHANOL"] != []
				@sorted_ethanol_array[i] = fuels_month[i]["ETHANOL"]
			else
				@sorted_ethanol_array[i] = nil
			end

		end

		@sorted_ethanol_array

	end

	def sorting_diesel_of_county(fuels_month)

		@sorted_diesel_array = []

		for i in 0..(fuels_month.length-1)

			if fuels_month[i]["DIESEL"] != []
				@sorted_diesel_array[i] = fuels_month[i]["DIESEL"]
			else
				@sorted_diesel_array[i] = nil
			end

		end

		@sorted_diesel_array

	end

		#Generate the graph of county monthly
		#Generate the graph of country monthly
		def generate_monthly_graph_county(average_gasoline, average_ethanol, average_diesel)

			months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
						"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

			titulo = "Preço do combustivel no decorrer do ano de #{params[:year_selected]}, #{params[:county_searched].titleize} - #{params[:state_searched].titleize}"

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
				graph.chart({defaultSeriesType: 'line'})


			end

		end

end #end of class
