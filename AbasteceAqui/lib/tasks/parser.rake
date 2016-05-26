namespace :parser do

require 'roo'

  task :run => :environment do
    @states = Hash.new

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
      puts "Region save true"
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
      puts "State save true"
      @states[name] = Hash.new

      return state
    end


    def build_county(county_name, state_object)

      #iteration in hash
      @states.each do |state, counties|
        if state == state_object.name
          counties.each do |county, id|
            if county_name == county
              return id
            end
          end
        end
      end

      county = County.new
      county.name = county_name
      county.state_id = state_object.id
      county.save
      puts "County save true"
      @states[state_object.name][county_name] = county.id
      return county.id
    end

    def build_fuel_research(date, county_id)
      fuel_researches = FuelResearch.all
      fuel_researches.each do |t|
        if(t.date == date && t.county_id == county_id)
          return t
        end
      end

      fuel_research = FuelResearch.new
      fuel_research.date = date
      fuel_research.county_id = county_id
      fuel_research.save
      puts "FuelResearch save true"
      return fuel_research
    end

    def build_fuel_type(type_name, unit_of_measurement)
      fuel_types = FuelType.all
      fuel_types.each do |t|
        if(t.type_name == type_name)
          return t
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


      file = Roo::Spreadsheet.open( "parser_data/Combustiveis.xlsx" )
      file.default_sheet = file.sheets.first

      14.upto(20) do |line|

        #Region
        region_name = file.cell(line, 'C')
        region = build_region(region_name)

        #State
        state_name = file.cell(line, 'D')
        state = build_state(state_name, region)

        #County
        county_name = file.cell(line, 'E')
        county_id = build_county(county_name, state)

        #FuelResearch
        date = file.cell(line, 'A')
        fuel_research = build_fuel_research(date, county_id)


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
