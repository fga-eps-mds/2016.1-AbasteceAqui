class FuelResearch < ActiveRecord::Base

	belongs_to :county
	has_many :fuels
	
end
