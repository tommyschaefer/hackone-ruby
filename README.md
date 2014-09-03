### HackOne Ruby Gem

This is a tool for parsing hacker resumes in the CommonHack JSON format, with a few adjustments made from the original [library made for CommonHack by Marcus Yearwood](https://github.com/myearwood/commonhack). It provides a simple and easy way to extract information from the JSON feed.

### Installation

To install this gem, download it from the RubyGems repository.

```
gem install hackone
```

### Usage

Use the gem by creating a CommonHack object. This can be created using an external URL or a file on the system. Both of the examples below are acceptable.

```
app = HackOne.parse("file.json")
app = HackOne.parse("http://www.hackone.co/bilawal.json")
app = HackOne.parse("http://externalurl.com/data.json")
```

Configure your API key (optional) to have access to private profiles. These can be obtained by emailing bilawal@hackcard.org with your hackathon details.

```
HackOne.api_key = ""
```

Once you have created the app object, you can start accessing the information form the application. Basic information can be accessed using dot notation.

````
puts app.username
puts app.email
puts app.shirtSize
puts app.public
puts app.lastUpdated

``` 

The more detailed information must be accessed using subcategories. The subcategories available are :
```
app.bio()
app.education()

app.work()
app.hackathons()
app.projects()
app.skills()

```

The first two subcategories are hashes, and the data can be accessed buy passing the field you want to the function. An example of this is accessing the gender with the code **app.bio("gender")** . The last 4 subcategories return arrays so the array must be iterated through, and the attributes must be extracted from each item in the  array. This code snippet illustrates this.

```
app.work().each do |job|
	puts "company: #{job["company"]}"
	puts "position: #{job["position"]}"
end


```


### License

MIT License