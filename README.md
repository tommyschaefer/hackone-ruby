### CommonHack Ruby Gem

This is a tool for parsing hacker resumes in the CommonHack JSON format. It provides a simple and easy way to extract information from the JSON feed.

### Installation

To install this gem, download it from the RubyGems repository.

```
gem install commonhack
```

### Usage

Use the gem by creating a CommonHack object. This can be created using an external URL or a file on the system. Both of the examples below are acceptable.

```
app = CommonHack.new("file.json")
app = CommonHack.new("http://externalurl.com/data.json")
```

Once you have created the app object, you can start accessing the information form the application. Basic information can be accessed using dot notation.

````
puts app.username
puts app.email
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


### Additional notes

This code will evolve if/as the CommonHack JSON spec evolves. I welcome any feedback you have :)