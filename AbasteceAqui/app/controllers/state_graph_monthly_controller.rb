class StateGraphMonthlyController < ApplicationController

	MONTHS = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
				"Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"]

	# index page
	def state_monthly

		@states = State.fill_states
		@state_searched = params[:state_searched]
		
		find_years()
		@year_searched = params[:years].to_i

		# when string is and cast to integer it becomes 0
		if @year_searched != 0
			all_medias = get_monthly_state_fuel_media(@state_searched, @year_searched)
			generate_monthly_graph_by_state(all_medias)
		else
			# do nothing
		end

	end

	# generate the chart of state monthly
	def generate_monthly_graph_by_state(all_medias)

		titulo = "Preço do combustivel no decorrer do ano - #{@state_searched} #{@year_searched}"

		@chart = LazyHighCharts::HighChart.new('graph') do |f|
			f.title(text:  titulo)
			f.xAxis(categories: MONTHS)
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

	# find all years of the BD
	def find_years

		@years = Set.new
		all_researches = FuelResearch.find_all_researches

		all_researches.each do |research|

			@years.add(research.date.year)

		end

		@years = @years.to_a

		return @years

	end

	# find all researches of an year of a state
	def find_researches_of_year(state, year)

		counties = State.search_state_counties(state, "object")
		
		researches_of_year = []

		counties.each do |county|
			
			research = County.researches_of_year(county, year)

			research.each do |r|
				researches_of_year << r
			end

		end

		return researches_of_year

	end

	# create fuels hash
	def create_fuels_hash

		fuels = Hash.new

		(1..12).each do |month|

			gas = []
			diesel = []
			ethanol = []
			fuels[month] = [ethanol, gas, diesel]
		
		end

		return fuels

	end

	# get all monthly media of the states
	def get_monthly_state_fuel_media(state, year)

		researches_of_year = find_researches_of_year(state, year)

		fuels = create_fuels_hash()

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

			@ethanol_media << (f[0].sum / f[0].size.to_f).round(3)
			@gas_media << (f[1].sum / f[1].size.to_f).round(3)
			@diesel_media << (f[2].sum / f[2].size.to_f).round(3)

		end

		all_medias = [@gas_media, @ethanol_media, @diesel_media]

		return all_medias

	end

end