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

  describe "#education" do
    it "returns the correct educational experiences" do
      expect(@app.education).to eq [{"institution"=>"MIT", "areas"=>["Computer Science"], "studyType"=>"Bachelor's", "start"=>"2012", "end"=>"2016"}]
    end
  end

  describe "#work" do
    it "returns the correct work experience" do
      expect(@app.work).to eq [{"company"=>"Groupon", "position"=>"Software Engineering Intern", "start"=>"June 2014", "end"=>"Aug 2014", "description"=>"Worked on user interfaces for financial engineering, etc."}]
    end
  end

  describe "#hackathons" do
    it "returns the correct hackathons" do
      expect(@app.hackathons).to eq [{"name"=>"Greylock Hackfest", "season"=>"Summer", "year"=>"2014", "awards"=>["Finalist"], "project"=>{"name"=>"sense.js", "link"=>"http://sense-js.jit.su", "image"=>"<link to your image>", "description"=>"An HTML5 Interaction Library", "technologies"=>["Javascript", "HTML5", "Node.js", "Socket.IO"]}}]
    end
  end

  describe "#projects" do
    it "returns the correct projects" do
      expect(@app.projects).to eq [{"name"=>"commonhack", "description"=>"A common hackathon application/hacker showcase", "link"=>"http://commonhack.org", "image"=>"<link to your image>"}]
    end
  end

  describe "#skills" do
    it "returns the correct skills" do
      expect(@app.skills).to eq ["Javascript", "HTML", "CSS", "Python", "Node"]
    end
  end

end
