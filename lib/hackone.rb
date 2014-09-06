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
    @api_key || ''
  end

  def self.parse(url)
    new(url)
  end

  def initialize(url)
    if url.include?('http://') || url.include?('https://')
      url += "?api_key=#{HackOne.api_key}" if HackOne.api_key != ''
      body = open(url)
      contents = body.read
    else
      # its a local file, so use File.Read
      file = File.open(url, 'rb')
      contents = file.read
    end

    begin
      @result = cleanse(JSON.parse(contents))
    rescue
      raise HackOneInvalidCommonHackDocument
    end

    fail HackOneUserNotFound if @result['error'] == 'user_not_found'
    fail HackOneInvalidAPIKey if @result['error'] == 'api_key_invalid'

    # Basic level.
    @username = @result[:username]
    @email = @result[:email]
    @lastUpdated = @result[:lastUpdated] # <- snake casify
    @shirtSize = @result[:shirtSize] # <- snake casify
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
  def fetch(parent, method)
    parent = parent.to_sym
    method = method.to_sym

    item = @result[parent] ? @result[parent][method] : nil

    return item if item
    'Error: Cannot find this field.'
  end

  # A method to help extract the bio part of the application
  # "fields", returns a list of fields
  def bio(key = nil)
    result =
      if a = @result[:bio]
        key ? a[key.to_sym] : a
      else
        nil
      end

    result
  end

  def education
    @result[:education]
  end

  def work
    @result[:work]
  end

  def hackathons
    @result[:hackathons]
  end

  def projects
    @result[:projects]
  end

  def skills
    @result[:skills]
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
    if h.is_a?(Hash)
      h.reduce({}) { |i, (k, v)| i[k.to_sym] = cleanse(v); i }
    elsif h.is_a?(Array)
      h.map { |e| cleanse(e) }
    else
      h
    end
  end
end
