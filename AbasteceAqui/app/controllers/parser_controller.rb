class ParserController < ApplicationController

require 'roo'


	def import
	file = Roo::Spreadsheet.open( "parser_data/Combustiveis.xlsx" )
	file.default_sheet = file.sheets.first

		1.upto(1) do |line| # just wait for the sheet opening delay 
			msg = file.cell(line, 'A')
		end

		14.upto(file.last_row) do |line|

			#Region
			region_name = file.cell(line, 'C')
			region = build_region(region_name)

			#State
			state_name = file.cell(line, 'D')
			state = build_state(state_name, region)

			#County
			county_name = file.cell(line, 'E')
			number_of_gas_station = file.cell(line, 'F')
			county = build_county(county_name, number_of_gas_station, state)

			#Fuel
			date = file.cell(line, 'A')
			fuel_type = file.cell(line, 'B')
			min_resale_price = file.cell(line, 'J')
			medium_resale_price = file.cell(line, 'H')
			max_resale_price = file.cell(line, 'K')
			min_distribuition_price = file.cell(line, 'P')
			medium_distribuition_price = file.cell(line, 'N')
			max_distribuition_price = file.cell(line, 'Q')
			resale_standard_deviation = file.cell(line, 'I')
			distribuition_standard_deviation = file.cell(line, 'O')
	
			build_fuel(date, fuel_type, min_resale_price, medium_resale_price, max_resale_price, 
			resale_standard_deviation, min_distribuition_price, medium_distribuition_price,
			max_distribuition_price, distribuition_standard_deviation, county)
		end

	end


	def build_region(name)
		regions = Region.all

		regions.each do |t|
			if(t.name == name)
				return t
			end

		end

		region = Region.new
		region.name = name
		region.save
		region
	end

	def build_state(name, region)
		states = State.all

		states.each do |t|
			if(t.name == name)
				return t
			end
		end

		state = State.new
		state.name = name
		state.region_id = region.id
		state.save
		state
	end

	def build_county(name, number_of_gas_station, state)
		county = County.new
		county.name = name
		county.number_of_gas_station = number_of_gas_station
		county.state_id = state.id
		county.save
		county
	end

	def build_fuel(date, fuel_type, min_resale_price, medium_resale_price, max_resale_price, 
		resale_standard_deviation, min_distribuition_price, medium_distribuition_price,
		max_distribuition_price, distribuition_standard_deviation, county)


		fuel = Fuel.new
		fuel.date = date
		fuel.fuel_type = fuel_type
		fuel.min_resale_price = min_resale_price
		fuel.medium_resale_price = medium_resale_price
		fuel.max_resale_price = max_resale_price
		fuel.resale_standard_deviation = resale_standard_deviation
		fuel.min_distribuition_price = min_distribuition_price
		fuel.medium_distribuition_price = medium_distribuition_price
		fuel.max_distribuition_price = max_distribuition_price
		fuel.distribuition_standard_deviation = distribuition_standard_deviation
		fuel.county_id = county.id

		fuel.save

	end


end