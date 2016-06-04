class Fuel < ActiveRecord::Base

	belongs_to :fuel_research
	belongs_to :fuel_type

	def self.fuels_latest_researches_counties(researches)

		fuels = []

		for research in researches

			for fuel in research.fuels

				name = fuel.fuel_type.type_name
				fuel_hash = Hash.new
				fuel_hash[name] = research
				fuels << fuel_hash

			end

		end

		return fuels
		
	end

end
