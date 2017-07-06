keep_playing = true 
while keep_playing == true
	test = 1
	puts "please enter a number:"
	print "> "
	while test == 1
		input = gets.chomp
		testVariable = input 	
		input = input.to_i
		input = input.to_s
		if input == testVariable
			test = 0
		else 
			puts "that is not a number"
		end
	end
	input = input.to_i
	if input > 10
		puts "that number is bigger than 10"
	elsif input < 10 
		puts "that number is smaller than 10"
	elsif input == 10 
		puts "that number is equal to 10"
	end 
	puts "would you like to enter another number? enter 'yes' or 'no'"
	another_number = gets.chomp
	if another_number == "yes"
	puts "ok, Here we go."
	else
	puts "thanks for playing."
	keep_playing = false 
	end 
end
number = rand(101) 
puts "this is a random number: #{number}"