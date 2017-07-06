# calculates the amount total price of any resturants
# used in any state

puts "###" * 35

$total_price = 0
$total_with_tax = 0 
$appetizers = []
$appetizers_price =[]
$drinks = []
$drinks_price = []
$entrees = []
$entrees_price = []
$extras = []
$extras_price = []
$desserts = []
$desserts_price = []
$tax = 0
$tip = 0
$check = true
$enter_stuff = true

# add an appetizer 
def add_appetizer()
	puts "what is the name of the appetizer?"
	input = gets.chomp
	$appetizers[$appetizers.length] = input
	puts "how much is the appetizer?"
	$check = true
	while $check 
		print "$ "
		input = gets.chomp
		compare = input 
		input = input.to_f
		#puts input
		input = input.to_s
		#puts input
		#puts compare
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid price"
		end
	end
	$appetizers_price[$appetizers_price.length] = input 
end

#add a drink 
def add_drink()
	puts "what is the name of the drink?"
	input = gets.chomp
	$drinks[$drinks.length] = input
	puts "how much is the drink?"
	$check = true
	while $check 
		print "$ "
		input = gets.chomp
		compare = input 
		input = input.to_f
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid price"
		end
	end
	$drinks_price[$drinks_price.length] = input 
end

#add entree
def add_entree()
	puts "what is the name of the entree?"
	input = gets.chomp
	$entrees[$entrees.length] = input
	puts "how much is the entree?"
	$check = true
	while $check 
		print "$ "
		input = gets.chomp
		compare = input 
		input = input.to_f
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid price"
		end
	end
	$entrees_price[$entrees_price.length] = input 
end

#add extra
def add_extra()
	puts "what is the name of the extra?"
	input = gets.chomp
	$extras[$extras.length] = input
	puts "how much is the extra?"
	$check = true
	while $check 
		print "$ "
		input = gets.chomp
		compare = input 
		input = input.to_f
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid price"
		end
	end
	$extras_price[$extras_price.length] = input
end

#add dessert 
def add_dessert()
	puts "what is the name of the dessert?"
	input = gets.chomp
	$desserts[$desserts.length] = input
	puts "how much is the dessert?"
	$check = true
	while $check 
		print "$ "
		input = gets.chomp
		compare = input 
		input = input.to_f
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid price"
		end
	end
	$desserts_price[$desserts_price.length] = input
end

#what is $tax
def define_tax()
	puts "what percentage is the tax?"
	$check = true
	while $check 
		input = gets.chomp
		compare = input 
		input = input.to_f
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid tax"
		end
	end
	$tax = input
end 

#display total 
def display_total
	for x in $appetizers_price
		$total_price += x
	end
	for x in $drinks_price
		$total_price += x
	end
	for x in $entrees_price
		$total_price += x
	end
	for x in $extras_price
		$total_price += x
	end
	for x in $desserts_price
		$total_price += x
	end
	#-----------------
	$tax = define_tax
	add_tip
	if $tax < 1.0 
		$tax +=1
	elsif $tax < 1
		$tax = $tax/100
		$tax = $tax + 1 
	end
	$total_price *= $tax
	$total_price = $total_price + $tip
	$total_price = $total_price.round(2)
	display_food
	if $total_price < 0
		puts "LUKE STOP IT!!!"
	else
		puts " \nthe price is: #{$total_price}"
	end
end

#repeats the asking for the entrys
def add_item()
	print "    1: add appetizer\n    2: add drink\n    3: add entree\n    4: add extra\n    5: add dessert\n    6: go back\n\n\n>  "
	$check = true
	while $check 
		input = gets.chomp
		compare = input 
		input = input.to_i
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid answer"
		end
	end
	if input == 1 
		add_appetizer
	elsif input == 2
		add_drink
	elsif input == 3
		add_entree
	elsif input == 4
		add_extra
	elsif input == 5
		add_dessert
	elsif input == 6
		puts "ok"
	end
end

#display food
def display_food
	x = 0
	while x < $appetizers.length
		puts "  appetizers: #{$appetizers[x]} - #{$appetizers_price[x]}"
		x += 1 
	end	
	x = 0
	while x < $entrees.length
		puts "  entrees:  #{$entrees[x]} - #{$entrees_price[x]}"
		x += 1 
	end
		x = 0
	while x < $drinks.length
		puts "  drinks: #{$drinks[x]} - #{$drinks_price[x]}"
		x += 1 
	end
		x = 0
	while x < $extras.length
		puts "  extras:  #{$extras[x]} - #{$extras_price[x]}"
		x += 1 
	end
		x = 0
	while x < $desserts.length
		puts "  desserts: #{$desserts[x]} - #{$desserts_price[x]}"
		x += 1 
	end
end

#tipping
def add_tip
	puts "how much are you going to tip?"
	$check = true
	while $check 
		print "$ "
		input = gets.chomp
		compare = input 
		input = input.to_f
		#puts input
		input = input.to_s
		#puts input
		#puts compare
		if compare == input
			$check = false
			input = input.to_f
		else
			puts "that is not a valid tip"
		end
	end
	$tip = input
end

#reset
def reset
$total_price = 0
$total_with_tax = 0 
$appetizers = []
$appetizers_price =[]
$drinks = []
$drinks_price = []
$entrees = []
$entrees_price = []
$extras = []
$extras_price = []
$desserts = []
$desserts_price = []
$tax = 0
$tip = 0
$check = true
$enter_stuff = true
puts "the items are gone"
end
#the actual code
puts "to enter a price, if the value is an integer, you must add ad '.0' to the end.
do not add exess decimal places.
also to choose an item, enter the integer before the option."
while $enter_stuff
	puts "    1: add item\n    2: calculate total\n    3: exit\n    4: reset"
	print ">"
	$check = true
	while $check 
		input = gets.chomp
		compare = input 
		input = input.to_i
		input = input.to_s
		if compare == input
			$check = false
			input = input.to_i
		else
			puts "that is not a valid answer\nyou must answer with a number shown above"
		end
	end
	if input == 1 
		add_item
	elsif input == 2
		display_total
	elsif input == 3
		$enter_stuff = false
	elsif input == 4
		reset
	end
end

