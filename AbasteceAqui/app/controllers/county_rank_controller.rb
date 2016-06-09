class CountyRankController < ApplicationController

  def index

  end

  def county_rank_by_date

    find_counties()
    find_last_research_of_counties(@counties)
    find_county_fuels_last_research(@researches)
    sorted_counties(@counties_fuels)

  end


  def find_counties

		@counties = County.fill_counties()

		return @counties

	end

  def find_last_research_of_counties(counties)

		@researches = FuelResearch.fill_object_last_research(counties)

		return @researches

	end

  def find_county_fuels_last_research(researches)

    @counties_fuels = Fuel.county_fuels_last_research_order(researches)

    return @counties_fuels

  end

  def sorted_counties(counties_fuels)

    @sorted_counties = County.sort_counties_by_fuel_price(counties_fuels)

    return @sorted_counties

  end

end
