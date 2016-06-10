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

	def self.find_counties_by_fuel_sorted(fuels)

		counties_sorted = []

		fuels.each do |fuel|

			counties_sorted << fuel.fuel_research.county

		end

		return counties_sorted

	end

end
