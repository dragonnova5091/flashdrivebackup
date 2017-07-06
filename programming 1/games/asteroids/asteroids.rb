require 'gosu'

class GameWindow < Gosu::Window
	def are_touching?(obj1, obj2)
		obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
	end
	def button_down(id)
		if id == Gosu::KbSpace
			@bullets.push(Bullet.new(self, @player.x, @player.y, @player.angle))
		end
		if id == Gosu::KbP
			if @big_asteroids.length > 0
			@big_asteroids.each do |asteroid|
				asteroid.de
			end
		end
		if @medium_asteroids.length > 0
			@medium_asteroids.each do |asteroid|
				asteroid.de
			end
		end
		if @small_asteroids.length > 0
			@small_asteroids.each do |asteroid|
				asteroid.de
			end
		end
		end
	end
	def initialize
		super(800, 600)
		self.caption = "Asteroids"
		@font = Gosu::Font.new(30)
		@background = Background.new(self)
		@big_asteroids = [] 
		@medium_asteroids = [] 
		@small_asteroids = [] 
		@bullets = []
		@increase = 0
		(5+@increase).times do 
			x = rand(0..800)
			while x > 200 && x < 600
				x = rand(0..800)
			end
			y = rand(0..600)
			while y > 200 && y < 600
				y = rand(0..600)
			end
				@big_asteroids.push(Asteroid.new(self, 88, 88, 1, x, y))
		end
		@player = Player.new(self)
	end
	def update 
		#makes more asteroids 
		if @big_asteroids.length == 0 && @medium_asteroids.length == 0 && @small_asteroids.length == 0 
			@increase += 2
			(5+@increase).times do 
			x = rand(0..800)
			while x > 200 && x < 600
				x = rand(0..800)
			end
			y = rand(0..600)
			while y > 200 && y < 600
				y = rand(0..600)
			end
				@big_asteroids.push(Asteroid.new(self, 88, 88, 1, x, y))
		end
		end
		#collisions 
		@big_asteroids.each do |asteroid| 
			if are_touching?(@player, asteroid)
				@big_asteroids = []
				@medium_asteroids = [] 
				@small_asteroids = [] 
				@player.center
			end
		end
		@medium_asteroids.each do |asteroid| 
			if are_touching?(@player, asteroid)
				@big_asteroids = []
				@medium_asteroids = [] 
				@small_asteroids = [] 
				@player.center
			end
		end
		@small_asteroids.each do |asteroid| 
			if are_touching?(@player, asteroid)
				@big_asteroids = []
				@medium_asteroids = [] 
				@small_asteroids = [] 
				@player.center
			end
		end
		if @bullets.length > 0
		@bullets.each do |bullet|
			if @big_asteroids.length > 0 
			@big_asteroids.each do |asteroid| 
				if are_touching?(bullet, asteroid)
					@bullets -= [bullet]
					(rand(1..3)).times do 
					x = asteroid.x + rand(-20..20)
					y = asteroid.y + rand(-20..20)
						@medium_asteroids.push(Asteroid.new(self, 66, 66, 2, x, y))
						@big_asteroids -= [asteroid]
					end
				end
			end
			end
			if @medium_asteroids.length > 0 
				@medium_asteroids.each do |asteroid| 
					if are_touching?(bullet, asteroid)
						@bullets -= [bullet]
						(rand(2..5)).times do 
							x = asteroid.x + rand(-20..20)
							y = asteroid.y + rand(-20..20)
							@small_asteroids.push(Asteroid.new(self, 30, 30, 3, x, y))
							@medium_asteroids -= [asteroid]
						end
					end
				end
			end
			if @small_asteroids.length > 0 
				@small_asteroids.each do |asteroid| 
					if are_touching?(bullet, asteroid)
						@bullets -= [bullet]
						@small_asteroids -= [asteroid]
					end
				end
			end
		end
		end
		#movement and wrapping
		if @big_asteroids.length > 0
			@big_asteroids.each do |asteroid|
				asteroid.move
				asteroid.wrap
			end
		end
		if @medium_asteroids.length > 0
			@medium_asteroids.each do |asteroid|
				asteroid.move
				asteroid.wrap
			end
		end
		if @small_asteroids.length > 0
			@small_asteroids.each do |asteroid|
				asteroid.move
				asteroid.wrap
			end
		end
		if @bullets.length > 0 
			@bullets.each do |bullet|
				bullet.move
			end
		end
		if @bullets.length > 0 
			@bullets.each do |bullet|
				if bullet.x > 800 || bullet.x < 0 || bullet.y > 600 || bullet.y < 0
				@bullets -= [bullet]
				end
			end 
		end 
		@player.move
		@player.wrap
		#player movement 
		if button_down?(Gosu::KbA)
			@player.turn_left
		end
		if button_down?(Gosu::KbD)
			@player.turn_right
		end
		if button_down?(Gosu::KbW)
			@player.accelerate
		end
		if button_down?(Gosu::KbS)
			@player.slow_down
		end
	end 
	def draw 
		@player.draw
		@background.draw
		if @big_asteroids.length > 0
			@big_asteroids.each do |asteroid|
				asteroid.draw
			end
		end
		if @medium_asteroids.length > 0
			@medium_asteroids.each do |asteroid|
				asteroid.draw
			end
		end
		if @small_asteroids.length > 0 
			@small_asteroids.each do |asteroid| 
				asteroid.draw
			end
		end
		if @bullets.length > 0 
			@bullets.each do |bullet|
				bullet.draw
			end
		end
	end
end

class Asteroid 
	attr_reader :x, :y, :width, :height
	def initialize(the_window, width, height, size, x, y)
		@angle = rand(0..360)
		@width = width
		@height = height
		if size == 1 
		@x = rand(0..800-@width)
		while @x > 200 && @x < 600
			@x = rand(0..800-@width)
		end
		@y = rand(0..800-@height)
		while @y > 200 && @y < 600
			@y = rand(0..800-@height)
		end
		else 
			@x = x 
			@y = y
		end
		#determines the image of the ateroid --->
		if size == 1 
			@image = Gosu::Image.new(the_window, "./asteroids/big_asteroid.png")
		elsif size == 2 
			num = rand(1..2)
			if num == 1 
				@image = Gosu::Image.new(the_window, "./asteroids/medium_asteroid_1.png")
			elsif num == 2 
				@image = Gosu::Image.new(the_window, "./asteroids/medium_asteroid_2.png")
			end
		elsif size == 3 
			num = rand(1..4)
			if num == 1 
				@image = Gosu::Image.new(the_window, "./asteroids/small_asteroid_1.png")
			elsif num == 2 
				@image = Gosu::Image.new(the_window, "./asteroids/small_asteroid_2.png")
			elsif num == 3 
				@image = Gosu::Image.new(the_window, "./asteroids/small_asteroid_3.png")
			elsif num == 4 
				@image = Gosu::Image.new(the_window, "./asteroids/small_asteroid_4.png")
			end
		end
		#to here
	end
	def move 
		@x_vel = Gosu::offset_x(@angle, 1)
		@y_vel = Gosu::offset_y(@angle, 1)
		@x += @x_vel
		@y += @y_vel
	end
	def draw 
		@image.draw_rot(@x, @y, 1, @angle)
		
	end
	def wrap 
		if @y < -10 - @height 
			@y = 590 
		end
		if @y > 600
			@y = 10 - @height 
		end
		if @x < -1 - @width  
			@x = 790 + @width 
		end
		if @x > 800 
			@x = 10 - @width 
		end
	end
	def de
		@x = 400
		@y = 300 
	end
end

class Player
	attr_reader :x, :y, :angle, :width, :height
	def initialize(the_window)
		@angle = 45
		@x = 400
		@y = 300 
		@x_vel = 0 
		@y_vel = 0
		@width = 22
		@height = 22 
		@sprite = 0
		@image = Gosu::Image.new(the_window, "player_stationary.png")
		#animations
		@images_animations = [
		Gosu::Image.new("./player_move_animation/player_1.png"),
		Gosu::Image.new("./player_move_animation/player_2.png"),
		Gosu::Image.new("./player_move_animation/player_3.png"),
		Gosu::Image.new("./player_move_animation/player_4.png"),
		Gosu::Image.new("./player_move_animation/player_1.png"),
		]
	end
	def center
		@x = 380
		@y = 280
	end
	
	def draw 
		@image.draw_rot(@x, @y, 2, @angle+45)
		@image = @images_animations[@sprite]
		#@image.draw_rot(@x, @y, 1, 90)
		'''
		@num = 0
		if @num >= 30
			if @sprite >= 4
				@sprite = 0
			end
			@sprite += 1
			@num = 0
		end
		@num += 1'''
	end
	def turn_left 
		@angle -= 5 
	end 
	def turn_right 
		@angle += 5
	end 
	def accelerate
		#increases the speed of the player
		#if @x_vel <10 
			@x_vel = Gosu::offset_x(@angle, 4)
		#end
		#if @y_vel < 10 
			@y_vel = Gosu::offset_y(@angle, 4)
		#end
	end
	def move
		#moves and slows the player
		@x += @x_vel
		@y += @y_vel
		@x_vel *= 0.97
		@y_vel *= 0.97
	end
	def slow_down
		@x_vel *= 0.9
		@y_vel *= 0.9
	end
	def wrap
		if @y < -22 
			@y = 600 
		elsif @y > 600 
			@y = -22 
		end
		if @x < -22 
			@x = 800 
		elsif @x > 800 
			@x = -22
		end
	end
end 

class Bullet
	attr_reader :x, :y, :width, :height
	def initialize(the_window, x, y, angle)
		@angle = angle
		@x = x
		@y = y
		@width = 6 
		@height = 6  
		@image = Gosu::Image.new(the_window, "bullet.png")
	end
	def draw 
		@image.draw_rot(@x, @y, 1, @angle)
	end
	def move
		@x_vel = Gosu::offset_x(@angle, 8)
		@y_vel = Gosu::offset_y(@angle, 8)
		@x += @x_vel
		@y += @y_vel
	end
end

class Background
	def initialize(the_window)
		@image = Gosu::Image.new(the_window, "background.png")
	end
	def draw 
		@image.draw(0, 0, -1)
	end
end

window = GameWindow.new
window.show

