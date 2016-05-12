require "rails_helper"

RSpec.describe Region, type: :model do 

	before do

		region = Region.new(id: 1, name: "SUL")
		region.save

		state1 = State.new(id: 1, name: "PARANA", region_id: 1)
		state2 = State.new(id: 2, name: "RIO GRANDE DO SUL", region_id: 1)
		state1.save
		state2.save

	end


	describe "#.states" do

		it "Should return number of states of a region" do
			states = Region.find(1).states

			expect(states.count).to eq(2)

		end

	end

end