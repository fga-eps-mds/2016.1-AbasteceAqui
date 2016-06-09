class CountyRankController < ApplicationController

  def index

  end

  def county_rank_by_date

    find_counties()
    find_last_research_of_counties(@counties)
    find_county_fuels_last_research(@researches)
    fill_researches_by_fuel_price(@counties_fuels)
    fill_counties_by_fuel_price(@sorted_research)

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

    @counties_fuels = Fuel.county_fuels_last_research(researches)

    return @counties_fuels

  end

  def fill_researches_by_fuel_price(counties_fuels)

    @sorted_research = FuelResearch.sort_researches_by_fuel_price(counties_fuels)

    return @sorted_research

  end

  def fill_counties_by_fuel_price(sorted_research)

    @sorted_counties = County.sort_counties_by_fuel_price(sorted_research)

    return @sorted_counties

  end

end
