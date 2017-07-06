def cheese_and_crackers(cheese_count, boxes_of_crackers)
	puts "you hae #{cheese_count} chesses"
	puts "you have #{boxes_of_crackers} boxes of crackers"
	puts "man, thats enough for a party"
	puts "get a blanket.\n\n"
end
puts "we can just give the function numbers directly:"
cheese_and_crackers(20, 30)
puts  "or we can use variables from our script:"
amount_of_cheese = 10
amount_of_crackers = 50
cheese_and_crackers(amount_of_cheese, amount_of_crackers)
puts "we can use input fromour user..."
puts "enter how many crackers you want:"
amount_of_crackers = gets.chomp.to_i
puts "how many cheeses wuld you like:"
amount_of_cheese = gets.chomp.to_i 
cheese_and_crackers(amount_of_cheese, amount_of_crackers)
puts "we can even do math inside too:"
cheese_and_crackers(10+20, 5+6)
puts "and we can combine the two, variables and mathe:"
cheese_and_crackers(amount_of_cheese +100, amount_of_crackers+1000)