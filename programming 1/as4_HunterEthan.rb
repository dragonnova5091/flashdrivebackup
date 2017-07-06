puts "what is the upper limit of the number to guess: \n> "
test = 1
while test == 1
		high_number = gets.chomp
		testVariable = high_number 	
		high_number = high_number.to_i
		high_number = high_number.to_s
		if high_number == testVariable
			test = 0
			high_number = high_number.to_i
			if high_number <= 10
				puts "that is too low"
				test = 1
			end
		else 
			puts "that is not a valid answer"
		end
end
high_number = high_number + 1 
high_number = high_number.to_i
game_play = 0
best_times = []
while game_play == 0
guess_number = rand(high_number)
start = Time.new
puts "Ok, we generated a number between 0 and #{high_number - 1}\nmake your guess:"
sucess = 0
guesses = []
while sucess == 0
input = gets.chomp
if input == "check  the   answer"
	puts guess_number
end
test = 1
while test == 1
		check = input 	
		input = input.to_i
		input = input.to_s
		if input == check
			test = 0
			input = input.to_i
		else 
			puts "that is not a valid guess"
		end
end
#----
if input < guess_number 
	puts "your guess is lower than the number"
	guesses[guesses.length] = input
end
#higher
if input > guess_number 
	puts "your guess is higher than the number"
	guesses[guesses.length] = input

end 
if input == guess_number
	endtime = Time.new
	guesses[guesses.length] = input
	puts "good job, you guessed the number.\n it took you #{guesses.length} tries.\n your guesses were #{guesses.inspect}"
	difference = endtime - start
	if best_times.length == 0
		best_times[0] = difference
	end
	if best_times[0] > difference
		best_times[0] = difference
	elsif best_times[0] < difference
		best_times[best_times.length] = difference
	end 
	sucess = 1 
	puts "it took you #{difference} seconds to find the number"
	puts "your best time is #{best_times[0].round(2)}"
	puts "do you wish to play again?\nanswer 'yes' or 'no'" 
	input = gets.chomp
	if input == "yes"
		puts "ok here we go"
	else 
		puts "ok your best time was #{best_times[0]}"
		game_play = 1
	end
end 
end
end
