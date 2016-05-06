class FuelResearch < ActiveRecord::Base

	belongs_to :county
	has_many :fuels

	def self.search_fuels_research (last_research)

		research_date ||= "2016-02-01"
		fuel_researches = FuelResearch.find_by(date: research_date).fuels

		researches_of_fuels = []

		fuel_researches.each do |fuel|
			researches_of_fuels << fuel
		end

		return researches_of_fuels

	end
	
end
