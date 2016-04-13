class State < ActiveRecord::Base
	
	belongs_to :region
	has_many :counties

end
