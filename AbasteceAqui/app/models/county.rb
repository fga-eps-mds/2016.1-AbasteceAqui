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

	def self.sort_counties_by_fuel_price(counties_fuels)

		sorted_counties = []

		sorted_counties[0] = []
		for i in 0..(counties_fuels[0].length-1)

			fuel_reseach_county_id = FuelResearch.find_by(id: counties_fuels[0][i].fuel_research_id).county_id
			sorted_counties[0] << County.find_by(id: fuel_reseach_county_id)

		end

		sorted_counties[1] = []
		for i in 0..(counties_fuels[1].length-1)

			fuel_reseach_county_id = FuelResearch.find_by(id: counties_fuels[1][i].fuel_research_id).county_id
			sorted_counties[1] << County.find_by(id: fuel_reseach_county_id)

		end

		sorted_counties[2] = []
		for i in 0..(counties_fuels[2].length-1)

			fuel_reseach_county_id = FuelResearch.find_by(id: counties_fuels[2][i].fuel_research_id).county_id
			sorted_counties[2] << County.find_by(id: fuel_reseach_county_id)

		end

		return sorted_counties

	end

end
