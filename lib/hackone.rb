require 'json'
require 'open-uri'

# Built from the great work of Marcus Yearwood.
# Original repository: https://github.com/myearwood

class HackOneException < Exception; end
class HackOneInvalidAPIKey < Exception; end
class HackOneUserNotFound < Exception; end
class HackOneInvalidCommonHackDocument < Exception; end

class HackOne
	attr_reader :username, :email, :lastUpdated, :is_private, :shirtSize

	def self.api_key=(api_key)
		@api_key = api_key
	end

	def self.api_key
		@api_key || ""
	end

	def self.parse(url)
		new(url)
	end

	def initialize(url)
		if url.include? "http://" or url.include? "https://"
			url += "?api_key=#{HackOne.api_key}" if HackOne.api_key != ""
			body = open(url)
			contents = body.read
		else
			#its a local file, so use File.Read
			file = File.open("data.json", "rb")
			contents = file.read
		end

		begin
			@result = cleanse(JSON.parse(contents))
		rescue
			raise HackOneInvalidCommonHackDocument
		end

		if @result["error"] == "user_not_found"
			raise HackOneUserNotFound
		end

		if @result["error"] == "api_key_invalid"
			raise HackOneInvalidAPIKey
		end

		# Basic level.
		@username = @result[:username]
		@email = @result[:email]
		@lastUpdated = @result[:lastUpdated]
		@shirtSize = @result[:shirtSize]
		@is_private = @result[:private]
	end

	def private?
		@is_private
	end

	def public?
		!@is_private
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
	def bio
		return @result[:bio]
	end

	def education
		return @result[:education]
	end

	def work
		return @result[:work]
	end

	def hackathons
		return @result[:hackathons]
	end

	def projects
		return @result[:projects]
	end

	def skills
		return @result[:skills]
	end

  def method_missing(method, *args, &block)
    attr = method.to_s
    if @result
      @result[attr]
    else
      super
    end
  end


private
 def cleanse(h)
    nh = nil
    nh = {} if h.is_a? Hash
    nh = [] if h.is_a? Array
    nh = h if nh.nil?
    h.each { |k, v| nh[k.to_sym] = cleanse(v) } if h.is_a? Hash
    h.each { |k| nh.push(cleanse(k)) } if h.is_a? Array
    nh
  end
end
