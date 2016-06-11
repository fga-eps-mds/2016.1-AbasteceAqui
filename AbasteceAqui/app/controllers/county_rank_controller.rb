class CountyRankController < ApplicationController

  def index

  end

  #action method
  def county_rank_by_ethanol()

    find_counties()
    find_last_research_of_counties(@counties)
    fill_fuels_last_research(@researches)
    find_ethanol_fuels_sorted(@fuels)
    find_counties_sorted_by_fuel(@ethanol_sorted)

  end

  def county_rank_by_gasoline()

    find_counties()
    find_last_research_of_counties(@counties)
    fill_fuels_last_research(@researches)
    find_gasoline_fuels_sorted(@fuels)
    find_counties_sorted_by_fuel(@gasoline_sorted)

  end

  def county_rank_by_diesel()

    find_counties()
    find_last_research_of_counties(@counties)
    fill_fuels_last_research(@researches)
    find_diesel_fuels_sorted(@fuels)
    find_counties_sorted_by_fuel(@diesel_sorted)

  end

  def find_counties

		@counties = County.fill_counties()

		return @counties

	end

  def find_last_research_of_counties(counties)

		@researches = FuelResearch.fill_object_last_research(counties)

		return @researches

	end

  def fill_fuels_last_research(researches)

    @fuels = Fuel.fuels_latest_researches_counties(researches)

    return @fuels

  end

  def find_ethanol_fuels_sorted(fuels)

    @ethanol_sorted = Fuel.ethanol_sorted(fuels)

    return @ethanol_sorted
  end

  def find_gasoline_fuels_sorted(fuels)

    @gasoline_sorted = Fuel.gasoline_sorted(fuels)

    return @gasoline_sorted

  end

  def find_diesel_fuels_sorted(fuels)

    @diesel_sorted = Fuel.diesel_sorted(fuels)

    return @diesel_sorted

  end

  def find_counties_sorted_by_fuel(fuels)

    @counties_sorted = County.find_counties_by_fuel_sorted(fuels)

    return @counties_sorted
  end

end
