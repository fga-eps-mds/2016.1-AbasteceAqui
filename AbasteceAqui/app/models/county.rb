class County < ActiveRecord::Base

	belongs_to :state
	has_many :fuel_researches
	delegate :name,  :to => :state, :prefix => true

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

	def self.find_counties_by_fuel_sorted(fuels)

		counties_sorted = []

		fuels.each do |fuel|

			counties_sorted << fuel.fuel_research.county

		end

		return counties_sorted

	end

	def self.researches_of_year(county_searched, year_searched)

		researches_of_year = []

		county_searched.fuel_researches.each do |research|

			if(year_searched == research.date.year)
				researches_of_year << research
			end
		end

		return researches_of_year

	end


	def self.fuels_of_year (years, counties_of_state)

		state_fuels_by_year = Hash.new

		years.each do |year|
			state_fuels_by_year[year] = []

			counties_of_state.each do |county|
				researches_of_county = County.find_by(name: county).fuel_researches
				FuelResearch.check_year_of_research(researches_of_county, state_fuels_by_year[year], year)
			end
		end

		return state_fuels_by_year

	end

end # end of class
