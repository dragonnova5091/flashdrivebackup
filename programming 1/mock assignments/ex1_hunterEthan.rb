require 'gosu'


class Game_Window < Gosu::Window
	def initialize
		@font = Gosu::Font.new(40)
		super(800, 600)
		self.caption = "Hello World"
	end
	def draw 
		@font.draw("Hello World!", 20, 20, 1)
		@font.draw("Hello Again.", 20, 70, 1)
		@font.draw("i like typing this", 20, 120, 1)
		@font.draw("this is fun", 20, 170, 1)
		@font.draw("well, not really", 20, 220, 1)
		@font.draw("i'd rather be playing a game or something", 20, 270, 1)
		@font.draw("mr. rankin said 'this stuff is awesome!'", 20, 320, 1)
	end
end

window = Game_Window.new 
window.show