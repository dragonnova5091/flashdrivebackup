require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super(300, 300)
		self.caption = "card"
		@font = Gosu::Font.new(20)
		@show = false
		@words = IO.readlines("testwords.txt")
		@words = @words.shuffle
		num = 0
		@words.each do |pair|
			pair = pair.split("  ")
			@words[num] = pair 
			num += 1
		end
		@count = 0
	end
	def draw 
		#@font.draw("hello my good sir", 50, 50, 1)
		begin
		pair = @words[@count]
			word1 = pair[0]
			word2 = pair[1].chomp
		@font.draw(word1, 50, 50, 1)
		if @show == true 
			@font.draw(word2, 50, 100, 1)
			
		end
		rescue
			@font.draw("you are out of words", 50, 50, 1)
		end
	end 
	def update 
		
	end 
	def button_down(id)
		if id == Gosu::MsLeft
			if @show == true 
				@show = false 
				@count += 1
			else 
				@show = true
				
			end
			 
		end
	end
end

cards = GameWindow.new
cards.show