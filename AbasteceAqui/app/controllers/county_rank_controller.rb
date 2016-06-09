class CountyRankController < ApplicationController

  def index

  end

  def county_rank_by_date

    fill_object_county()
    find_last_research_of_counties(@counties)
    find_fuels_of_research(@researches)

  end

  def fill_object_county

    @counties = County.fill_counties();

    return @counties

  end

  def find_last_research_county(counties)

    @researches = FuelResearch.fill_object_last_research(counties)

    return @researches

  end

  def find_fuels_of_research(researches)

		@fuels = Fuel.fuels_latest_researches_counties(researches)

		return @fuels

	end

end
