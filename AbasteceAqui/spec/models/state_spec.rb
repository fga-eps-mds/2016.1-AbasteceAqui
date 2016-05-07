require "rails_helper"

RSpec.describe State, type: :model do

	before do 

		state1 = State.new(id: 1, name: "PARA", region_id: 1)
		state2 = State.new(id: 2, name: "MARANHAO", region_id: 2)
		state3 = State.new(id: 3, name: "DISTRITO FEDERAL", region_id: 4)

		state1.save
		state2.save
		state3.save

	end

	describe "#fill_states" do

		it "Ordered state names" do

			state_names = State.fill_states

			expect(state_names).to eql(["DISTRITO FEDERAL","MARANHAO", "PARA"])

		end

	end

	describe "#fill_object_states" do 

		it "Find 2 states" do

			expect((State.fill_object_states).count).to eq(3)
			
		end

	end

end