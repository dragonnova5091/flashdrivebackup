require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super(800, 800)
		self.caption = "81 Square"
		@big_grid = Grid_big.new(self)
		@arrow = Arrow.new(self)
		@turn = 0 #0 -- > red || 1 --> blue
		@xs = []
		@os = [] 
		x = 105
		y = 105
		@small_grids = []
		9.times do 
			@small_grids.push(Grid_small.new(self, x, y))
			x += 200 
			if x > 600
				y += 200 
				x = 105
			end
		end
		
		#testing
		#@x.push(X.new(self, 108, 108))
		#@o.push(O.new(self, 570, 577))
		
		@time = 0
	end
	
	def update
		@time -= 1 
		if button_down?(Gosu::MsLeft)
			if @time <= 0
				@arrow.change_turn
				@time = 10
				puts mouse_x
				puts mouse_y
			end
		end
	end
	
	def draw
	
		@arrow.draw(mouse_x, mouse_y)
	
		@big_grid.draw
		for grid in @small_grids
			grid.draw
		end
		@xs.each do |x|
			x.draw
		end
		@os.each do |o|
			o.draw
		end
		
	end 
	
	def place_xo(x, y)
		
		
	end
end

#------------------------------------------------------------------------------------

class Grid_big
	attr_reader :x, :y
	def initialize(the_window)
		@x = 100
		@y = 100
		@image = Gosu::Image.new("big_grid.png")
		
	end
	
	def draw
		@image.draw(x, y, 0)
	end
end

#------------------------------------------------------------------------------------

class Grid_small
	attr_reader :x, :y
	def initialize(the_window, x, y)
		@x = x
		@y = y
		@image = Gosu::Image.new("small_grid.png")
	end
	
	def draw
		@image.draw(x, y, 2)
	end
end

#------------------------------------------------------------------------------------

class X
	attr_reader :x, :y
	def initialize(the_window, x, y)
		@x = x 
		@y = y
		@image = Gosu::Image.new("X.png")
		
	end
	
	def snap
		
	end
	
	def draw 
		@image.draw(x, y, 2)
	end
end

#------------------------------------------------------------------------------------

class O
	attr_reader :x, :y
	def initialize(the_window, x, y)
		@x = x
		@y = y 
		@image = Gosu::Image.new("O.png")
	end
	
	def draw
		@image.draw(x, y, 2)
	end
end

#------------------------------------------------------------------------------------

class Arrow
	def initialize(the_window)
		@x = 400 
		@y = 400 
		@imageblue = Gosu::Image.new("blue_arrow.png")
		@imagered = Gosu::Image.new("red_arrow.png")
		@turn = 0 #0 -- > red || 1 --> blue
	end
	
	def draw(x, y)
		@x = x 
		@y = y 
		case @turn 
			when 0 
				@imagered.draw(@x, @y, 5)
			when 1 
				@imageblue.draw(@x, @y, 5)
		end
	end
	
	def change_turn
		case @turn 
			when 0 
				@turn = 1 
			when 1 
				@turn = 0
		end
	end
end

#------------------------------------------------------------------------------------

class Surrond_box
	def initialize
		@x = -200
		@y = -200
	end
end
game = GameWindow.new
game.show