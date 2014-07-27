require 'spec_helper'

describe CommonHack do


	before :each do
		@app = CommonHack.new("test.json")
	end

	describe "#fetch_item" do

		it "gives an error message if the method doesn't exist" do

			error_msg = "Error: Cannot find this field."
			result = @app.fetch("bio","totally_flase_field")
			expect(result).to eql error_msg
		end

		it "returns the correct attribute for an existing method" do
			correct = "ehzhang@mit.edu"
			result = @app.fetch("bio","email")
			expect(result).to eql correct
		end

		#fetch will only work on a vaild object, so We do not need to check for blanks
		
	end
end