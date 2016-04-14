class ParserController < ApplicationController

require 'roo'


	def import
	file = Roo::Spreadsheet.open( "parser_data/Combustiveis.xlsx" )
	file.default_sheet = file.sheets.first

		14.upto(file.last_row) do |line|

			#Region
			region_name = line.cell(line, 'C')
			region = build_region(region_name)

			#State
			state_name = line.cell(line, 'D')
			state = build_state(state_name, region)

			#County
			county_name = line.cell(line, 'E')
			number_of_gas_station = line.cell(line, 'F')
			county = build_county(county_name, number_of_gas_station, state)

			#Fuel
			date = line.cell(line, 'A')
			type = line.cell(line, 'B')
			min_resale_price = line.cell(line, 'J')
			medium_resale_price = line.cell(line, 'H')
			max_resale_price = line.cell(line, 'K')
			min_distribuition_price = line.cell(line, 'P')
			medium_distribuition_price = line.cell(line, 'N')
			max_distribuition_price = line.cell(line, 'Q')
			resale_standard_deviation = line.cell(line, 'I')
			distribuition_standard_deviation = line.cell(line, 'O')
	
			build_fuel(date, type, min_resale_price, medium_resale_price, max_resale_price, 
			resale_standard_deviation, min_distribuition_price, medium_distribuition_price,
			max_distribuition_price, distribuition_standard_deviation, county)
		end

	end


	def build_region(name)
		region = Region.new
		region.name = name
		check_and_save(region)
	end

	def build_state(name, region)
		state = State.new
		state.name = name
		state.region_id = region.region_id
		check_and_save(state)
	end

	def build_county(name, number_of_gas_station, state)
		county = County.new
		county.name = name
		county.number_of_gas_station = number_of_gas_station
		county.state_id = state.state_id
		check_and_save(county)
	end

	def build_fuel(date, type, min_resale_price, medium_resale_price, max_resale_price, 
		resale_standard_deviation, min_distribuition_price, medium_distribuition_price,
		max_distribuition_price, distribuition_standard_deviation, county)


	fuel = Fuel.new
	fuel.date = date
	fuel.type = type
	fuel.min_resale_price = min_resale_price
	fuel.medium_resale_price = medium_resale_price
	fuel.max_resale_price = max_resale_price
	fuel.resale_standard_deviation = resale_standard_deviation
	fuel.min_distribuition_price = min_distribuition_price
	fuel.medium_distribuition_price = medium_distribuition_price
	fuel.max_distribuition_price = max_distribuition_price
	fuel.distribuition_standard_deviation = distribuition_standard_deviation
	fuel.county_id = county.county_id

	check_and_save(fuel)

	end


	def check_and_save(c)
	  begin
	    c.save!
	    c
	  rescue ActiveRecord::RecordInvalid
	    c = c.refresh!
	    c
	  end
	end

end