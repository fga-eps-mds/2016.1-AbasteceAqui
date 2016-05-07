require "rails_helper"

RSpec.describe State, type: :model do

	before do 

		state1 = State.new(id: 1, name: "PARA", region_id: 1)
		state2 = State.new(id: 2, name: "MARANHAO", region_id: 2)

		state1.save
		state2.save

	end

	describe "#fill_object_states" do 

		it "Find 2 states" do

			State.fill_object_states

			expect((State.fill_object_states).count).to eq(2)
		end

	end

end