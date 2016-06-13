class County < ActiveRecord::Base

	belongs_to :state
	has_many :fuel_researches

	def self.search_county_research (county_searched)

		if county_searched != nil
			county_researches = County.find_by(name: county_searched).fuel_researches

			researches_of_county = []

			county_researches.each do |research|
				researches_of_county << research.id
			end

			return researches_of_county.last
		else
			#do nothing
		end
	end

	def self.fill_counties ()

		counties = County.all
		return counties

	end

	def self.fuels_of_year (years, counties_of_state)

		@years_of_fuels_state = Hash.new

		years.each do |year|
			@years_of_fuels_state[year] = []

			counties_of_state.each do |county|
				researches_of_county = County.find_by(name: county).fuel_researches
				FuelResearch.check_year_of_research(researches_of_county, @years_of_fuels_state[year], year)
			end

		end

		return @years_of_fuels_state

	end

end
