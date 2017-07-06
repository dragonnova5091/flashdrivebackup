my_hash = {'dog' => 'canine', 'cat' => 'feline', 'person' => 'homo sapien', 4 => '4th value'}
puts my_hash.length
puts my_hash['dog']
puts my_hash
puts my_hash[4]
puts "\n"

people = Hash.new
people[:firstname] = "Ethan"
people[:city] = "Silverton"
people[:lastname] = "Hunter"
people[:state] = "Oregon"
puts people 
puts "
his name is #{people[:firstname]} #{people[:lastname]}
and he lives in #{people[:city]} #{people[:state]}
"

states = {
	'Oregon' => 'OR',
	'Florida' => 'FL',
	'California' => 'CA',
	'New York' => 'NY', 
	'Michigan' => 'MI'
}
cities = {
	'CA' => 'San Francisco',
	'MI' => 'Detroit',
	'FL' => 'Jacksonville',
	'NY' => 'New York City',
	'OR' => 'Portland'
}

puts "-" * 10
puts "NY State has: #{cities['NY']}"
puts "OR State has: #{cities['OR']}"

puts "-" * 10
puts "Michigan's abbreviation is #{states['Michigan']}"
puts "Florida's abbreviation is #{states['Florida']}"

puts "-" * 10
states.each do |state, abbrev|
	puts "#{state} is abbreviation #{abbrev}"
end

puts "-" * 10
cities.each do |abbrev, city|
	puts "#{abbrev} has the city #{city}"
end

puts "-" * 10 
states.each do |state, abbrev|
	city = cities[abbrev]
	puts "#{state} is abbreviated #{abbrev} and has the city #{city}"
end

puts "-" * 10
state = states['Texas']
if state == nil
	puts "sorry no Texas"
end


