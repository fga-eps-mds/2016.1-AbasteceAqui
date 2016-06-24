require "rails_helper"

RSpec.describe State, type: :model do

	before do
		state1 = State.new(id: 1, name: "PARA", region_id: 1)
		state2 = State.new(id: 2, name: "MARANHAO", region_id: 2)
		state3 = State.new(id: 3, name: "DISTRITO FEDERAL", region_id: 4)

		state1.save
		state2.save
		state3.save

		county1 = County.new(id: 1, name: "ABAETETUBA", state_id: 1)
		county2 = County.new(id: 2, name: "ACAILANDIA", state_id: 1)
		county3 = County.new(id: 3, name: "ADAMANTINA", state_id: 1)

		county1.save
		county2.save
		county3.save
	end

	describe "#fill_states" do

		it "Ordered state names" do

			state_names = State.get_state_names

			expect(state_names).to eql(["DISTRITO FEDERAL","MARANHAO", "PARA"])

		end
	end

	describe "#fill_object_states" do
		it "should return all states of database" do

			expect((State.get_state_objects).count).to eq(3)

		end
	end

	describe "#search_state_counties_by_name and comparing by array size" do
		it "should return all counties' name of a state" do

			counties_name = State.search_state_counties_by_name("PARA")

			expect(counties_name.count).to eql(3)

		end
	end

	describe "#search_state_counties_by_name and comparing by name" do
		it "should return all counties' name of a state" do

			counties_name = State.search_state_counties_by_name("PARA")

			expect(counties_name).to eql(["ABAETETUBA","ACAILANDIA","ADAMANTINA"])

		end
	end

	describe "#search_state_counties_by_object and comparing by array size" do
		it "should return all counties' object of a state" do

			counties_name = State.search_state_counties_by_object("PARA")

			expect(counties_name.count).to eql(3)

		end
	end

	describe "#search_state_counties_by_object and comparing by content value" do
		it "should return all counties' object of a state" do

			counties_name = State.search_state_counties_by_object("PARA")

			expect(counties_name[0].id).to eql(1)
			expect(counties_name[1].id).to eql(2)
			expect(counties_name[2].id).to eql(3)

		end
	end


end
