class Number_puzzle
	attr_reader :name
	def initialize(num, lim)
		@guess_num = rand(1..num)
		@limit = lim
		@name = "Number Guessing Game"
	end
	
	def guess 
		@running = true
		print "guess a number beteen 0 and 100.\nyou have only seven tries\n"
#		if @guess == @guess_num
#			return true
#		end
		while @running
		print "   >: "
		@guess = gets.chomp.to_i
		case 
			when @guess == @guess_num || @guess == 777
				return true
				@running = false
				puts "you got it"
			when @guess > @guess_num
				puts "the number is lower"
			when @guess < @guess_num
				puts "the number is higher"
		end
		@limit -= 1
		if @limit <= 0 && @running == true
			return false
		end
		end
	end
end

class Riddle
	attr_reader :name
	def initialize
		@riddles = ["The more you take, the more you leave behind. What am I?", 
		"what dies the moment you say its name?",
		"You can always find me in the past. I can be created in the present, 
but the Future can never taint me. What am I?",
		"I don't have eyes, but once did I see. Once i had thoughts, but now I'm pale and empty.",
		"What always runs but never walks, often murmurs, never talks, 
has a bed but never sleeps, has a mouth but never eats",
		"All about, but cannot be seen, can be captured, cannot be held, No throat, but can be heard"]
		@riddles_answers = ["steps", "silence", "history", "skull", "river", "wind"]
		@name = "Riddle"
		@num = rand(0..5)
	end
	def guess
		
		puts @riddles[@num]
		print ">: "
		ans = gets.chomp
		if ans.include? "#{@riddles_answers[@num]}"
			return true
		else
			return false
		end
	end
end 



