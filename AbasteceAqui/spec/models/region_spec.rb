require "rails_helper"

RSpec.describe Region, type: :model do 

	describe "#new" do

		it "Should be a instance of Region" do
			region = Region.new

			expect(region).to be_an_instance_of Region

		end

	end

end