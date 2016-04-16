class ParserController < ApplicationController

require 'roo'


	def import
	file = Roo::Spreadsheet.open( "parser_data/Combustiveis.xlsx" )
	file.default_sheet = file.sheets.first

		1.upto(1) do |line| # just wait for the sheet opening delay 
		end

		14.upto(100) do |line|

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
			type = file.cell(line, 'B')
			min_resale_price = file.cell(line, 'J')
			medium_resale_price = file.cell(line, 'H')
			max_resale_price = file.cell(line, 'K')
			min_distribuition_price = file.cell(line, 'P')
			medium_distribuition_price = file.cell(line, 'N')
			max_distribuition_price = file.cell(line, 'Q')
			resale_standard_deviation = file.cell(line, 'I')
			distribuition_standard_deviation = file.cell(line, 'O')
	
			build_fuel(date, type, min_resale_price, medium_resale_price, max_resale_price, 
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
		check_and_save(region)
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
		check_and_save(state)
		state
	end

	def build_county(name, number_of_gas_station, state)
		county = County.new
		county.name = name
		county.number_of_gas_station = number_of_gas_station
		county.state_id = state.id
		check_and_save(county)
		county
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
		fuel.county_id = county.id

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