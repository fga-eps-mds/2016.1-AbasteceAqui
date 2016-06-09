class Fuel < ActiveRecord::Base

	belongs_to :fuel_research
	belongs_to :fuel_type

	def self.fuels_latest_researches_counties(researches)

		fuels = []

		for research in researches

			for fuel in research.fuels

				fuels << fuel

			end

		end

		return fuels

	end

	def self.county_fuels_last_research_order(researches)

		counties_fuels = []
		gasoline_prices = []
		alcool_prices = []
		diesel_prices = []

		researches.each do |research|

			if(research.fuels.find_by(fuel_type_id: 1) != nil)
				alcool_prices << research.fuels.find_by(fuel_type_id: 1)
			else
				#do nothing
			end
			if(research.fuels.find_by(fuel_type_id: 2) != nil)
				gasoline_prices << research.fuels.find_by(fuel_type_id: 2)
			else
				#do nothing
			end

			if(research.fuels.find_by(fuel_type_id: 5) != nil)
				diesel_prices << research.fuels.find_by(fuel_type_id: 5)
			else
				#do nothing
			end

		end

		alcool_prices.sort_by! {|cheaper| cheaper.medium_resale_price}
		gasoline_prices.sort_by! {|cheaper| cheaper.medium_resale_price}
		diesel_prices.sort_by! {|cheaper| cheaper.medium_resale_price}

		counties_fuels[0] = alcool_prices
		counties_fuels[1] = gasoline_prices
		counties_fuels[2] = diesel_prices

		return counties_fuels

	end

end
