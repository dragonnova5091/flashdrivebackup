require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super(220, 220)
		self.caption = "tic tac toe"
		@grid  = Grid.new
		@mouse = Mouse.new
		@X = []
		@O = []
		
	end
	
	def draw 
		@grid.draw
		@mouse.draw(mouse_x, mouse_y)
		for x in @X
			x.draw
		end
		for o in @O
			o.draw
		end
	end
	
	def update
		
	end
	
	def button_down(id)
		if id == Gosu::MsLeft
			case @mouse.turn
				when 1
					@X.push(X.new(mouse_x, mouse_y))
				when 0
					@O.push(O.new(mouse_x, mouse_y))
			end
			puts mouse_x
			puts mouse_y
			@mouse.change_turn
		end
	end
end

class Grid 
	def initialize
		@x = 20 
		@y = 20
		@image = Gosu::Image.new("small_grid.png")
	end
	
	def draw 
		@image.draw(@x, @y, 1)
	end
end

class Mouse
	attr_reader :turn
	def initialize
		@x = 0 
		@y = 0
		@image_red = Gosu::Image.new("red_arrow.png")
		@image_blue = Gosu::Image.new("blue_arrow.png")
		@turn = 1
	end
	def draw(x, y)
		if @turn == 0
			@image_red.draw(x, y, 3)
		elsif @turn == 1
			@image_blue.draw(x, y, 3)
		end
	end
	def change_turn
		if @turn == 0 
			@turn = 1 
		elsif @turn == 1 
			@turn = 0
		end
	end
end

class X
	attr_reader :x, :y
	def initialize(x, y)
		@x = x 
		@y = y
		@image = Gosu::Image.new("X.png")
		snap
	end
	
	def snap
		#limits-x --> 20, 85, 145
		if @x >= 20 && @x <= 85
			@x = 22
		elsif @x >= 85 && @x <= 145 
			@x = 87
		elsif @x >= 145
			@x = 147
		end
		
		if @y >= 20 && @y <= 85
			@y = 22
		elsif @y >= 85 && @y <= 145 
			@y = 87
		elsif @y >= 145
			@y = 147
		end
	end
	
	def draw 
		@image.draw(x, y, 2)
	end
end

class O
	attr_reader :x, :y
	def initialize(x, y)
		@x = x
		@y = y 
		@image = Gosu::Image.new("O.png")
		snap
	end
	
	def draw
		@image.draw(x, y, 2)
	end
	
	def snap
		#limits-x --> 20, 85, 145
		if @x >= 20 && @x <= 85
			@x = 22
		elsif @x >= 85 && @x <= 145 
			@x = 87
		elsif @x >= 145
			@x = 147
		end
		
		if @y >= 20 && @y <= 85
			@y = 22
		elsif @y >= 85 && @y <= 145 
			@y = 87
		elsif @y >= 145
			@y = 147
		end
	end
end


game = GameWindow.new 
game.show




