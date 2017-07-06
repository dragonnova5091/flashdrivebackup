require 'gosu'

def diagonally(x1, y1, x2, y2)
	angle = Gosu::angle(x1, y2, x2, y2)
	return angle
end

class GameWindow < Gosu::Window
	def initialize
		super(800, 800)
		self.caption = "Godzilla"
		@background = Gosu::Image.new(self, "background.bmp")
		@tank = Tank.new(self, 400, 400)
	end
	
	def update
		@tank.bullet.each do |bullet|
			bullet.shoot
		end
	end
	
	def button_down(id)
		if id == (Gosu::KbSpace)
			@tank.shoot
		end
	end
	
	def draw
		@background.draw(0, 0, 0)
		@tank.draw
	end
end

class Godzilla
	def initialize
	end
end

class Tank
	attr_reader :x, :y, :upgrade, :bullet
	def initialize(the_window, x, y)
		@x = x
		@y = y
		@upgrade = 0
		@bullet = []
		@the_window = the_window
		if @upgrade == 0
			@image = Gosu::Image.new(the_window, "tank.bmp")
			@barrel = Gosu::Image.new(the_window, "tanktop.bmp")
		end
	end
	def draw
		@image.draw(@x, @y, 2)
		@barrel.draw(@x + 8, @y - 36, 3)
		@bullet.each do |bullet|
			bullet.draw
		end
	end
	def shoot
		@bullet.push(Bullet.new(@the_window, x, y, 1))#Gosu::Image.new(@the_window, "bullet.bmp")))
	end
end

class Bullet
	def initialize(the_window, x, y, image)
		@x = x
		@y = y
		@image = Gosu::Image.new(the_window, "bullet.bmp")
		@the_window = the_window
		
		#@slope_x = (@x - @the_window.mouse_x.to_f) / 100
		#@slope_y = (@y - @the_window.mouse_y.to_f) / 100
		@angle = diagonally(@x, @y, mouse_x, mouse_y)
	end
	def shoot
		#@x -= @slope_x * 10
		#@y -= @slope_y * 10
		@x += Gosu::offset_x(@angle, 10)
		@y += Gosu::offset_Y(@angle, 10)
	end
	def draw
		@image.draw(@x, @y, 1)
	end
end
window = GameWindow.new
window.show