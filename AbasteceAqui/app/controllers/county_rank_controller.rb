class CountyRankController < ApplicationController

  def index

    find_counties()
    find_last_research_of_counties(@counties)
    fill_fuels_last_research(@researches)
    find_ethanol_fuels_sorted(@fuels)
    find_gasoline_fuels_sorted(@fuels)
    find_diesel_fuels_sorted(@fuels)
    find_counties_sorted_by_ethanol(@ethanol_sorted)
    find_counties_sorted_by_gasoline(@gasoline_sorted)
    find_counties_sorted_by_diesel(@diesel_sorted)


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

  def find_counties_sorted_by_ethanol(fuels)

    @counties_sorted_ethanol = County.find_counties_by_fuel_sorted(fuels)

    return @counties_sorted_ethanol
  end

  def find_counties_sorted_by_gasoline(fuels)

    @counties_sorted_gasoline = County.find_counties_by_fuel_sorted(fuels)

    return @counties_sorted_gasoline
  end

  def find_counties_sorted_by_diesel(fuels)

    @counties_sorted_diesel = County.find_counties_by_fuel_sorted(fuels)

    return @counties_sorted_diesel
  end

end
