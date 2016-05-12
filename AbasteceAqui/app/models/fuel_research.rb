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
	
end
