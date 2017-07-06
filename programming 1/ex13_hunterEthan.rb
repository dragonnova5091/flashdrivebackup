number = [1, 2, 3, 4, 5]
fruits = ['apples', 'oranges', 'pears', 'apricots']
random = [1, "pennies", true, false, 2, "quarters"]
empty = []
puts "i just created 4 arrays"
puts "wow! they can hld al different types of data"
puts "i can even create empty arrays and fill them later"
puts "each element inside of an array has an index to indicate its location. but its a little weird... "
puts "indexes start at 0. for example, an array with 5 elements has an index from 0 -> 4"
puts "my favorite fruit is #{fruits[1]} but i like #{fruits[0]} too"
puts number[4] * number[3]
puts " i can even check the length of my array"
puts"my random array has #{random.length} elements inside"
puts "\n"
puts "i can even use my loop to put data in my empty array"
#this loop assigns random values to ive slots in my empty array 
index = 0 
while index < 5
	empty[index] = rand(1..100)
	index += 1 
end
puts "now i check whats inside an array"
puts empty.inspect