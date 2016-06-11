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

	def self.researches_of_year(county_searched, year_searched)

		researches_of_year = []

		county_searched.fuel_researches.each do |research|

			if(year_searched == research.date.year)
				researches_of_year << research
			end

		end

		return researches_of_year

	end

end
