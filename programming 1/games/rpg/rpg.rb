#RPG game 
# player must make it through a difficult arena
=begin
	this might work
class Dislay_select
	def initialize(the_window, num)
		@x = 600
		@y = 580
		@images = []
		num.times do
			@images.push = Gosu::Image.new(the_window, target.png)
		end
	end 
	def draw 
		@images.each do |image|
			image.draw(@x, @y, 3)
			@y += 40
		end
		@y = 580
	end
end

=end
require 'gosu'

class GameWindow < Gosu::Window 
	def initialize 
		super(1000, 900)
		self.caption = "This Game"
		$player_hp = 30 
		$weapon = false
		$room = 1 
		@background = Background.new(self)
		@font = Gosu::Font.new(30)
		@mouse = Gosu::Image.new(self, "mouse.png")
		@player_display = Player_display.new(self)
		@player_move = Player_moving.new(self)
		#room options ----------------------------------------------
		@room1_options = ["open the door and go south", "look around"]
		@room1_responses = ["the door is locked", "you find a key"]
		#-----------------------------------------------------------
		@display = Display.new
		@targets = []
		room_targets(@room1_options.length)
		
	end
	
	def are_touching?(obj1, obj2)
		obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
	end
	
	def button_down(id)
		if id == Gosu::MsLeft
			puts "MsLeft"
			if @targets.length > 0 
				@targets.each do |target|
					if Gosu.distance(target.x + 10, target.y + 10, mouse_x, mouse_y) < 10 
						puts "hit"
					end
				end
			end
		end
	end
	
	def room_targets(number)
		@targets = [] 
		y = 580 
		number.times do 
			@targets.push(Target.new(self, 610, y))
			y += 40
		end
	end
	
	def draw 
		@background.draw 
		@font.draw("Player HP = #{$player_hp}", 700, 20, 4)
		@player_display.draw
		@player_move.draw
		@mouse.draw(mouse_x, mouse_y, 5)
		@display.draw_options(@room1_options)
		if @targets.length > 0 
			@targets.each do |target|
				target.draw
			end
		end
	end
	
	def update 
		
	end
end

class Display
	def initialize
		@start_x = 650
		@start_y = 580
		@font = Gosu::Font.new(25)
	end
	def draw_options(options)
		@start_y = 580
		@options = options
		@options.each do |option|
			@font.draw(option, @start_x, @start_y, 3)
			@start_y += 40
		end
	end
	def draw_response(responses, id)
		@responses = responses
		@font.draw(@responses[id], 650, 470, 3)
	end
end

class Player_display 
	def initialize(the_window)
		@image = Gosu::Image.new(the_window, "./player_images/warrior_no_weapon.png")
	end
	def draw 
		@image.draw(700, 60, 1)
	end
end

class Player_moving
	def initialize(the_window)
		@x = 280 
		@y = 45 
		@image = Gosu::Image.new(the_window, "./player_images/warrior_inroom.png")
	end
	def draw 
		@image.draw(@x, @y, 1)
	end
	def move(x, y)
		@x = x 
		@y = y
	end
end 

class Target
	attr_reader :x, :y, :width, :height
	def initialize(the_window, x, y)
		@x = x 
		@y = y 
		@width = 20 
		@height = 20 
		@image = Gosu::Image.new(the_window, "target.png")
	end
	def draw 
		@image.draw(@x, @y, 2)
	end
end

class Background
	def initialize(the_window)
		@image = Gosu::Image.new(the_window, "room.png")
	end 
	def draw 
		@image.draw(0, 0, -1)
	end
end

window = GameWindow.new 
window.show

