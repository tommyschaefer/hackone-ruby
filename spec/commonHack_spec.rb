require 'spec_helper'

describe CommonHack do


	before :each do
		@app = CommonHack.new("test.json")
	end


	describe "#initialize" do

		it "retrives a correct file address and correct url and creates the commonApp object" do

			username ="ehzhang"
			@app_file = CommonHack.new("test.json")
			@app_web = CommonHack.new("http://pastebin.com/raw.php?i=FSBr9BCK")
			expect(@app_file.username).to eql username
			expect(@app_web.username).to eql username
		end

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

	describe "#check_accessors" do

		it "returns the username when asked" do
			correct = "ehzhang"
			expect(@app.username).to eql correct
		end

		it "returns the email when asked directly" do
			correct = "ehzhang@mit.edu"
			expect(@app.email).to eql correct
		end

		it "returns the lastUpdated date when asked" do
			correct = "Sat, 26 Jul 2014 01:55:43 GMT"
			expect(@app.lastUpdated).to eql correct
		end

	end


	describe "#check_bio" do

		it "returns the correct email when asked" do
			correct = "ehzhang@mit.edu"
			expect(@app.bio("email")).to eql correct
		end

		it "returns the correct phone when asked" do
			correct = "908-798-1998"
			expect(@app.bio("phone")).to eql correct
		end
	end

end