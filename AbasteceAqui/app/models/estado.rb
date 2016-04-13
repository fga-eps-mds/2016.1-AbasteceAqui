class Estado < ActiveRecord::Base
	belongss_to :regiao
	has_many :municipio
end
