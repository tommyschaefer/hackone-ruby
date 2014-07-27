require 'json'
require 'open-uri'


# graceful error handling

class CommonHack

	attr_reader :username,:email,:lastUpdated

	def initialize(url)


		# handle the errors for an invalid url 

		file = File.open("data.json", "rb")
		contents = file.read
		@result = JSON.parse(contents)


		#make the  basic first level info accessible
		@username = @result["username"]
		@email = @result["email"]
		@lastUpdated = @result["lastUpdated"]

	end

	def fetch(parent,method)

		item = @result[parent][method]
		if item != nil 
			return item
		else
			return "Error: Cannot find this field."
		end

	end

	def bio(method)

		if method != "all"

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

	def education(method)

		if method != "all"




	end

end


app = CommonHack.new("data.json")