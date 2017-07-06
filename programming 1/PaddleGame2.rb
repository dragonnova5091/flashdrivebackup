#in this step we will create a ball and make it appear in the middle of the window

require 'gosu'

class GameWindow < Gosu::Window 
	def initialize
		super(800, 600)
		self.caption = "My Pong Game "
		@background = Background.new(self)
		@ball = Ball.new(self)
		@left_paddle = Paddle.new(self, 20, "paddle_left.png")
		if $ai == false 
		@right_paddle = Paddle.new(self, 760, "paddle_right.png")
		else 
		@right_paddle = AIpaddle.new("paddle_right.png")
		end
		@score_left = 0
		@score_right = 0 
		@font = Gosu::Font.new(30)
	end
	def update 
		@ball.move
		if button_down?(Gosu::KbQ)
			@ball.move
		end
		if button_down?(Gosu::KbA)
			@ball.go_right
		end
		if button_down?(Gosu::KbW)
			@left_paddle.move_up 
		end
		if button_down?(Gosu::KbX)
			@left_paddle.move_down 
		end
		if $ai == false
			if button_down?(Gosu::KbO)
				@right_paddle.move_up 
			end 
			if button_down?(Gosu::KbM)
				@right_paddle.move_down
			end
		end
		if $ai 
			@right_paddle.track(@ball)
		end
		if are_touching?(@ball, @left_paddle)
			@ball.bounce
			@ball.speed_up
		end
		if are_touching?(@ball, @right_paddle)
			@ball.bounce
			@ball.speed_up
		end
		if @ball.x <= 0 
			@score_right += 1
			@ball.center
			@ball.bounce
		elsif @ball.x >= 780 
			@score_left += 1 
			@ball.center
			@ball.bounce
		end
		
	end
	def draw 
		@background.draw
		@ball.draw
		@left_paddle.draw 
		@right_paddle.draw 
		@font.draw(@score_left.to_s, 20, 20, 2)
		@font.draw(@score_right.to_s, 700, 20, 2)
		if @score_left >= 10 
			@font.draw("The Left Player Wins", 280, 490, 2)
			@ball.ending
		end
		if @score_right >= 10 
			@font.draw("The Right Player Wins", 280, 490, 2) 
			@ball.ending
		end
	end
	def are_touching?(obj1, obj2)
		obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
	end
end

class Ball
	attr_reader :x, :y, :width, :height
	def initialize(the_window) # the argument here is where the ball goes 
		@x = 200 # x location form the top left 
		@y = 200 # relative ot the top left 
		@width = 20 
		@height = 20
		@radius = 10
		@speed_up = 0
		@x_velocity = 5 * rand(-1..1) 
		while @x_velocity == 0 
			@x_velocity = 5 * rand(-1..1) 
		end
		@y_velocity = 5 * rand(-1..1)
		while @y_velocity == 0 
			@y_velocity = 5 * rand(-1..1)
		end
		@image = Gosu::Image.new(the_window, "ball.png") # the arguments here are where and then what
	end
	def draw  
		@image.draw(@x, @y, 2) # x coordinate , y coordinate, depth of image(z coordinate)
	end
	def move
		@x = @x + @x_velocity # this changes horzontal location
		@y = @y + @y_velocity # same for vertical location
		if @y > 580 
			@y_velocity *= -1 
		elsif @y < 0 
			@y_velocity *= -1
		end
	end
	def bounce 
		@x_velocity += (@speed_up/3)
		@x_velocity = @x_velocity * -1 
		if @y_velocity < 0
		@y_velocity -= (@speed_up/3)
		elsif @y_velocity > 0 
		@y_velocity += (@speed_up/3)
		end
	end
	def center
		sleep 1
		@x = 390 
		@y = 290
		@speed_up = 0
		@x_velocity = 5 * rand(-1..1) 
		while @x_velocity == 0 
			@x_velocity = 5 * rand(-1..1) 
		end
		@y_velocity = 5 * rand(-1..1)
		while @y_velocity == 0 
			@y_velocity = 5 * rand(-1..1)
		end
	end
	def ending
		@x = 390 
		@y = 190
		@x_velocity = 0 
		@y_velocity = 0 
	end
	def speed_up 
		@speed_up += 1 
		if @speed_up > 21 
			@speed_up = 21
		end
	end
	def go_right
		if @x_velocity < 0
			@x_velocity *= -1 
		end
	end
end

class Paddle 
	attr_reader :x, :y, :width, :height
	def initialize(the_window, x_position, image)
		@x = x_position
		@y = 300 
		@width = 20 
		@height = 60 
		@image = Gosu::Image.new(image)
	end
	def draw 
		@image.draw(@x, @y, 1)
	end 
	def move_up 
		if @y > 0 
			@y -= 10
		end
	end
	def move_down 
		if @y < 540
			@y += 10 
		end
	end
end

class AIpaddle
	attr_reader :x, :y, :width, :height
	def initialize(image)
		@x = 760 
		@y = 300 
		@width = 20 
		@height = 60 
		@image = Gosu::Image.new(image)
	end
	def draw 
		@image.draw(@x, @y, 1)
	end
	def track(ball)
		if @y + 20 < ball.y
			@y += 10
		end
		if @y + 20 > ball.y
			@y -= 10
		end
	end
end

class Background
  def initialize(the_window)
    @path = "./background.jpg"
    @x = 0
    @y = 0
    @background = Gosu::Image.new(the_window, @path)
  end

  def draw
    @background.draw(@x, @y, -1)
  end
end
puts "ready to play?"
input = gets.chomp.downcase
if input == "yes"
puts "do you want to play against an AI?"
$ai = gets.chomp.downcase 
if $ai == "yes"
$ai = true
sleep 2
window = GameWindow.new 
window.show
else 
$ai = false
sleep 2
window = GameWindow.new 
window.show
end
else  
exit
end
