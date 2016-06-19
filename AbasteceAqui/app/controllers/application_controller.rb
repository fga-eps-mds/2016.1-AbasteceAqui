class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	helper_method :generate_graph

	# generate a graph with fuels
	# xAxis has a default months array, but we can pass other params to it
	def generate_graph(gas, ethanol, diesel, title, xAxis = "months")

		if xAxis == "months"
			xAxis = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
					"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]
		else
			# if xAxis != months, xAxis is an array with all years, so we do nothing
		end

		titulo = "Preço do combustivel no decorrer do ano - Brasil #{@year_searched}"

		@chart = LazyHighCharts::HighChart.new('graph') do |graph|
			graph.title(text:  title)
			graph.xAxis(categories: xAxis)
			graph.series(name: "Preço Da Gasolina", yAxis: 0, data: gas)
			graph.series(name: "Preço Do Etanol", yAxis: 0, data: ethanol)
			graph.series(name: "Preço Do Diesel", yAxis: 0, data: diesel)

			graph.yAxis [
				{title: {text: "Preço Dos Combustíveis", margin: 70} },
			]

			graph.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
			graph.chart({defaultSeriesType: "line"})

		end

	end
	
end
