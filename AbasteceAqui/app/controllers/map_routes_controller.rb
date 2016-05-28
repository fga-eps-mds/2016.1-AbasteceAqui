class MapRoutesController < ApplicationController

	def index

		find_counties()

	end
	
	def find_counties

		@counties = County.fill_counties

	end
end