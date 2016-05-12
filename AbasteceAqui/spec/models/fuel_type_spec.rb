require "rails_helper"

RSpec.describe FuelType, type: :model do 

	describe "#new" do

		it "Should be a instance of FuelType" do
			fuel_type = FuelType.new

			expect(fuel_type).to be_an_instance_of FuelType

		end

	end

end