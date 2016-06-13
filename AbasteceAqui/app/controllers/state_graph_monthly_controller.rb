class StateGraphMonthlyController < ApplicationController

	def state_monthly

		@states = State.fill_states
		@state_searched = params[:state_searched]
		
		find_years()
		@year_searched = params[:years].to_i

		if @year_searched != nil
			all_medias = get_monthly_state_fuel_media
			generate_monthly_graph_by_state(all_medias)
		else
			# do nothing
		end

	end

	def generate_monthly_graph_by_state(all_medias)

		months = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
				"Julho", "Agosto", "Setembro", "Outurbro", "Novembro", "Dezembro"]

		titulo = "Preço do combustivel no decorrer do ano"

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title(text:  titulo)
			f.xAxis(categories: months)
			f.series(name: "Preço Da Gasolina", yAxis: 0, data: all_medias[0])
			f.series(name: "Preço Do Etanol", yAxis: 0, data: all_medias[1])
			f.series(name: "Preço Do Diesel", yAxis: 0, data: all_medias[2])

			f.yAxis [
				{title: {text: "Preço Dos Combustíveis", margin: 70} },
			]

			f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
			f.chart({defaultSeriesType: "line"})
		end
	end

	def find_years

		@years = Set.new
		all_researches = FuelResearch.find_all_researches

		all_researches.each do |research|

			@years.add(research.date.year)

		end

		@years = @years.to_a

		return @years

	end

	def get_monthly_state_fuel_media

		counties = State.find_by(name: @state_searched).counties
		
		diesel_prices = []
		ethanol_prices = []
		gas_prices = []

		researches_of_year = []

		counties.each do |county|
			
			research = County.researches_of_year(county, @year_searched)

			research.each do |r|
				researches_of_year << r
			end

		end

		fuels = Hash.new

		researches_of_year.each do |research|

			gas = []
			diesel = []
			ethanol = []
			fuels[research.date.month] = [ethanol, gas, diesel]
		
		end

		researches_of_year.each do |research|

			research.fuels.each do |f|
				if f.medium_resale_price != 0.0
					if f.fuel_type_id == 1
						fuels[research.date.month][0] << f.medium_resale_price
					elsif f.fuel_type_id == 2
						fuels[research.date.month][1] << f.medium_resale_price
					elsif f.fuel_type_id == 5
						fuels[research.date.month][2] << f.medium_resale_price
					end
				end
			end		
		end


		@ethanol_media = []
		@gas_media = []
		@diesel_media = []

		fuels.each do |month, f|

			@ethanol_media << f[0].sum / f[0].size.to_f
			@gas_media << f[1].sum / f[1].size.to_f	
			@diesel_media << f[2].sum / f[2].size.to_f

		end

		all_medias = [@gas_media, @ethanol_media, @diesel_media]

		return all_medias

	end

end