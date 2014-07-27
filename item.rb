require 'json'
require 'open-uri'


# graceful error handling

class CommonHack

	#makes these three fields accessable via dot notation     

	attr_reader :username,:email,:lastUpdated


	#intitalizes the class

	def initialize(url)


		if url.include? "http://" or url.include? "https://"
			body = open(url)
			contents = body.read

		else
			#its a local file, so use File.Read
			file = File.open("data.json", "rb")
			contents = file.read
		end

		@result = JSON.parse(contents)

		#make the  basic first level info accessible
		@username = @result["username"]
		@email = @result["email"]
		@lastUpdated = @result["lastUpdated"]

	end


	# A helper method. All the names methods use it to
	# interact with the named method

	def fetch(parent,method)

		item = @result[parent][method]
		if item != nil 
			return item
		else
			return "Error: Cannot find this field."
		end

	end


	# A method to help extract the bio part of the application
	# "fields", returns a list of fields

	def bio(method)

		if method != "fields"

			return fetch("bio",method)

		else 

			return [
					"firstName",
					"lastName",
					"gender",
					"email",
					"phone",
					"dietaryRestrictions",
					"summary",
					"location",
					"websites",
					"resume",
					"picture"
			]
		end

	end

	# These fields return arrays so they pass the array to the user,
	# rather than looping through them

	def education(method)

		return @result["education"]
	end


	def work()

		return @result["work"]
	end 

	# hackathons is the same thing

	def hackathons()

		return @result["hackathons"]
	end

	def projects()

		return @result["projects"]
	end

	def skills()

		return @result["skills"]
	end

end


app = CommonHack.new("data.json")