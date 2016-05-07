require 'rails_helper'

RSpec.describe SearchController, type: :controller do

	before do

		state1 = State.new(id: 1, name: "PARA", region_id: 1)
		state2 = State.new(id: 2, name: "MARANHAO", region_id: 2)
		state3 = State.new(id: 3, name: "DISTRITO FEDERAL", region_id: 3);
		
		state1.save
		state2.save
		state3.save
	end

  describe "#find_states" do
    it "Should be all states" do
      states = controller.find_states

      expect(states).to eql(["DISTRITO FEDERAL", "MARANHAO", "PARA"])
    end
  end
  

end