require 'commonhack'


app = CommonHack.new("spec/test.json")
puts "username: #{app.username}"
puts "email: #{app.email}"

puts ""

app.work().each do |job|
	puts "company: #{job["company"]}"
	puts "position: #{job["position"]}"
end