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


	def self.ethanol_sorted(researches)

		ethanol = []

		researches.each do |research|

			if(research.fuel_type_id == 1)
				ethanol << research

			else
				#do nothing

			end

		end

		ethanol.sort_by! {|const_sort| const_sort.medium_resale_price}

		return ethanol

	end

	def self.gasoline_sorted(researches)

		gasoline = []

		researches.each do |research|

			if(research.fuel_type_id == 2)
				gasoline << research

			else
				#do nothing

			end

		end

		gasoline.sort_by! {|const_sort| const_sort.medium_resale_price}

		return gasoline

	end

	def self.diesel_sorted(researches)

		diesel = []

		researches.each do |research|

			if(research.fuel_type_id == 5)
				diesel << research

			else
				#do nothing

			end

		end

		diesel.sort_by! {|const_sort| const_sort.medium_resale_price}

		return diesel

	end

end
