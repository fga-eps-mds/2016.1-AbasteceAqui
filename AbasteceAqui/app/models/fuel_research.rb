class FuelResearch < ActiveRecord::Base

	belongs_to :county
	has_many :fuels

	def self.search_fuels_research(id_last_research)


		fuel_researches = FuelResearch.find_by(id: id_last_research).fuels

		researches_of_fuels = []

		fuel_researches.each do |fuel|
			researches_of_fuels << fuel
		end

		return researches_of_fuels

	end

	def self.fill_object_last_research(counties) 

		last_researches  = []

		counties.each do |county|
			last_researches << county.fuel_researches.last
		end

		return last_researches

	end

	def self.find_all_researches()

		all_researches = FuelResearch.all

		return all_researches
	end

	def self.check_year_of_research(researches_of_county, researches_of_year, year)
		researches_of_county.each do |research|

			if research.date.strftime("%Y").to_i == year

				research.fuels.each do |fuel|
					researches_of_year << fuel
				end

			end

		end

	end

	def self.find_years_of_researches(researches)
			year = []

			researches.each do |research|

				year << research.date.year

			end

			year.uniq!

			return year

	end

	#This method returns fuels of the choosen year by month.
	def self.fuels_of_year_by_month (year, researches)

		researches_of_year = []

		researches.each do |researches_of_selected_year|

			if researches_of_selected_year.date.year == year.to_i

				researches_of_year << researches_of_selected_year

			end

		end

		return researches_of_year

	end

	def self.find_all_researches_of_county(county_searched)

		county = County.find_by(name: county_searched)
		all_researches_of_county = county.fuel_researches

		return all_researches_of_county

	end

	# get all years from db
	# return a years array with all years that we have at db
	def self.get_all_years()

		years = Set.new()
		all_researches = FuelResearch.find_all_researches()

		all_researches.each do |research|

			years.add(research.date.year)

		end

		# convert a years set to an year array
		years = years.to_a

		return years

	end
	
end

