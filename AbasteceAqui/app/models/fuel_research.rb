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
	
end
