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

  def find_counties_sorted_by_fuel(fuels)

    @counties_sorted = County.find_counties_by_fuel_sorted(fuels)

    return @counties_sorted
  end

end
