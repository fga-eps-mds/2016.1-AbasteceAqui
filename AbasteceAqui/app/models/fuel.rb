class Fuel < ActiveRecord::Base

	belongs_to :fuel_research
	belongs_to :fuel_type

end
