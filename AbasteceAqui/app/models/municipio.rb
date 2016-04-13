class Municipio < ActiveRecord::Base
	belongss_to :estado
	has_many :combustivel
end
