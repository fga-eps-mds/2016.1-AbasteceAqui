require "rails_helper"

RSpec.describe County, type: :model do

	before do

		county1 = County.new(id: 1, name: "ABAETETUBA", state_id: 1)
		county2 = County.new(id: 2, name: "BRASILIA")
		fuel_research1 = FuelResearch.new(id: 1, date: "2016-01-01", county_id: 1)
		fuel_research2 = FuelResearch.new(id: 2, date: "2016-02-01", county_id: 1)
		fuel_research3 = FuelResearch.new(id: 3, date: "2016-03-01", county_id: 1)

		county1.save
		county2.save
		fuel_research1.save
		fuel_research2.save
		fuel_research3.save

	end

	describe "#search_county_research" do
		it "Find last reserach equal 3" do

			last_research = County.search_county_research("ABAETETUBA")

			expect(last_research).to eq(3)

		end
	end

	describe "#fill_counties" do
		it "should returns all counties in database" do
			counties1 = County.all
			counties2 = County.fill_counties

			expect(counties1).to eq(counties2)
		end
	end

end
