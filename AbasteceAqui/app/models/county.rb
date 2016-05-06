class County < ActiveRecord::Base

	belongs_to :state
	has_many :fuel_researches

	def self.search_county_research (county_searched)

		county_searched ||= "SAO PAULO"
		county_researches = County.find_by(name: county_searched).fuel_researches

		researches_of_county = []

		county_researches.each do |research|
			researches_of_county << research.id
		end

		return researches_of_county.last

	end

end
