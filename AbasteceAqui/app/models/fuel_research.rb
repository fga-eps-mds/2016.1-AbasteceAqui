class FuelResearch < ActiveRecord::Base

	belongs_to :county
	has_many :fuels

	def self.search_fuels_research (id_last_research)


		fuel_researches = FuelResearch.find_by(id: id_last_research).fuels

		researches_of_fuels = []

		fuel_researches.each do |fuel|
			researches_of_fuels << fuel
		end

		return researches_of_fuels

	end

	def self.fill_object_last_research (counties)


		last_researches  = []

		counties.each do |county|
			last_researches << county.fuel_researches.last
		end

		return last_researches

	end

	def self.sort_researches_by_fuel_price(counties_fuels)

		sorted_research = []

		sorted_research[0] = []
		for i in 0..(counties_fuels[0].length-1)

				sorted_research[0] << counties_fuels[0][i].fuel_research_id

		end

		sorted_research[1] = []
		for i in 0..(counties_fuels[1].length-1)

				sorted_research[1] << counties_fuels[1][i].fuel_research_id

		end

		sorted_research[2] = []
		for i in 0..(counties_fuels[2].length-1)

				sorted_research[2] << counties_fuels[2][i].fuel_research_id

		end

		return sorted_research

	end

end
