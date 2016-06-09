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

	def self.sort_counties_by_fuel_price(sorted_research)

		sorted_counties = []

		sorted_counties[0] = []
		for i in 0..(sorted_research[0].length-1)
			county_id = FuelResearch.find_by(id: sorted_research[0][i]).county_id
			sorted_counties[0] << County.find_by(id: county_id).name
		end

		sorted_counties[1] = []
		for i in 0..(sorted_research[1].length-1)
			county_id = FuelResearch.find_by(id: sorted_research[1][i]).county_id
			sorted_counties[1] << County.find_by(id: county_id).name
		end

		sorted_counties[2] = []
		for i in 0..(sorted_research[2].length-1)
			county_id = FuelResearch.find_by(id: sorted_research[2][i]).county_id
			sorted_counties[2] << County.find_by(id: county_id).name
		end

		return sorted_counties

	end

end
