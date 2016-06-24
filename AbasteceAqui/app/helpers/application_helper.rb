module ApplicationHelper

  # generate a graph with fuels
	# xAxis has a default months array, but we can pass other params to it
	def generate_graph(gas, ethanol, diesel, title, xAxis = "months")

		if xAxis == "months"
			xAxis = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
					"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]


			remove_needless_values!(gas)
			remove_needless_values!(ethanol)
			remove_needless_values!(diesel)

			# get the greater array length and sum 1 to know how mutch months are used
			used_months = [gas.length, ethanol.length, diesel.length].max + 1
			xAxis = xAxis.take(used_months)

		else
			# if xAxis != months, xAxis is an array with all years, so we do nothing
		end

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

	# remove needless values from the given array
	# we use it to remove all nil values that we doesn't need at graph
	def remove_needless_values!(fuel)

		last_valid_value = 0

		for i in 0..11

			if fuel[i] != nil
				last_valid_value = i
			end

		end

		# remove all values from last_valid_value + 1 until the end o array
		fuel.slice!((last_valid_value + 1)..(fuel.length - 1))

	end

end
