require 'roo'

namespace :parser do

  task :prepare do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end

  task :process => :environment do

    def build_region(name)
      regions = Region.all

      regions.each do |region|
        if(region.name == name)
          return region
        end

      end

      region = Region.new
      region.name = name
      region.save
      puts "Region save true"
      region
    end

    def build_state(name, region)
      states = region.states

      states.each do |state|
        if(state.name == name)
          return state
        end
      end

      state = State.new
      state.name = name
      state.region_id = region.id
      state.save
      puts "State save true"

      return state
    end


    def build_county(county_name, state)

      counties = state.counties

      counties.each do |county|
        if county_name == county.name
          return county
        end
      end

      county = County.new
      county.name = county_name
      county.state_id = state.id
      county.save
      puts "County save true"
      return county
    end

    def build_fuel_research(date, county)

      fuel_researches = county.fuel_researches

      fuel_researches.each do |fuel_research|
        if(fuel_research.date == date)
          return fuel_research
        end
      end

      fuel_research = FuelResearch.new
      fuel_research.date = date
      fuel_research.county_id = county.id
      fuel_research.save
      puts "FuelResearch save true"
      return fuel_research
    end

    def build_fuel_type(type_name, unit_of_measurement)

      fuel_types = FuelType.all

      fuel_types.each do |fuel_type|
        if(fuel_type.type_name == type_name)
          return fuel_type
        end
      end

      fuel_type = FuelType.new
      fuel_type.type_name = type_name
      fuel_type.unit_of_measurement = unit_of_measurement
      fuel_type.save
      puts "FuelType save true"
      return fuel_type
    end

    def build_fuel(number_of_gas_station, min_resale_price, medium_resale_price, max_resale_price,
      resale_standard_deviation, min_distribuition_price, medium_distribuition_price,
      max_distribuition_price, distribuition_standard_deviation, fuel_research, fuel_type)


      fuel = Fuel.new
      fuel.number_of_gas_station = number_of_gas_station
      fuel.min_resale_price = min_resale_price
      fuel.medium_resale_price = medium_resale_price
      fuel.max_resale_price = max_resale_price
      fuel.resale_standard_deviation = resale_standard_deviation
      fuel.min_distribuition_price = min_distribuition_price
      fuel.medium_distribuition_price = medium_distribuition_price
      fuel.max_distribuition_price = max_distribuition_price
      fuel.distribuition_standard_deviation = distribuition_standard_deviation
      fuel.fuel_research_id = fuel_research.id
      fuel.fuel_type_id = fuel_type.id
      fuel.save
      puts "Fuel save true"
      return fuel
    end
  end

  task :run => :environment do
    Rake::Task['parser:process'].invoke


      file = Roo::Spreadsheet.open( "parser_data/Combustiveis.xlsx" )
      file.default_sheet = file.sheets.first

      14.upto(109480) do |line|

        #Region
        region_name = file.cell(line, 'C')
        region = build_region(region_name)

        #State
        state_name = file.cell(line, 'D')
        state = build_state(state_name, region)

        #County
        county_name = file.cell(line, 'E')
        county = build_county(county_name, state)

        #FuelResearch
        date = file.cell(line, 'A')
        fuel_research = build_fuel_research(date, county)


        #FuelType
        type_name = file.cell(line, 'B')
        unit_of_measurement = file.cell(line, 'G')
        fuel_type = build_fuel_type(type_name, unit_of_measurement)


        #Fuel
        number_of_gas_station = file.cell(line, 'F')
        min_resale_price = file.cell(line, 'J')
        medium_resale_price = file.cell(line, 'H')
        max_resale_price = file.cell(line, 'K')
        min_distribuition_price = file.cell(line, 'P')
        medium_distribuition_price = file.cell(line, 'N')
        max_distribuition_price = file.cell(line, 'Q')
        resale_standard_deviation = file.cell(line, 'I')
        distribuition_standard_deviation = file.cell(line, 'O')

        build_fuel(number_of_gas_station, min_resale_price, medium_resale_price, max_resale_price,
        resale_standard_deviation, min_distribuition_price, medium_distribuition_price,
        max_distribuition_price, distribuition_standard_deviation, fuel_research, fuel_type)
      end
  end

end
