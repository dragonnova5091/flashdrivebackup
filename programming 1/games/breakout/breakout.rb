require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super(800, 600)
		self.caption = "Hurdy Durdy"
		@score = 0
		@font = Gosu::Font.new(30)
		@background = Background.new(self)
		@bullets = []
		@lose = false
		#@ball_array = []
		#2.times do
		#	@ball_array.push(Ball.new(self))
		#end
		brick_placement = 10
		@layer_1_brick_array = []
		13.times do
			@layer_1_brick_array.push(Brick.new(self, brick_placement, 100, "brick_layer1.png"))
			brick_placement += 60
		end
		brick_placement = 10
		@layer_2_brick_array = []
		13.times do
			@layer_2_brick_array.push(Brick.new(self, brick_placement, 150, "brick_layer2.png"))
			brick_placement += 60
		end
		brick_placement = 10
		@layer_3_brick_array = []
		13.times do
			@layer_3_brick_array.push(Brick.new(self, brick_placement, 200, "brick_layer3.png"))
			brick_placement += 60
		end
		brick_placement = 10
		@layer_4_brick_array = []
		13.times do
			@layer_4_brick_array.push(Brick.new(self, brick_placement, 250, "brick_layer4.png"))
			brick_placement += 60
		end
		@big_brick = Big_brick.new(self, 340, 10, "big_brick.png")
		@power_up_brick = []
		brick_placement = 100
		2.times do
			@power_up_brick.push(Brick.new(self, brick_placement, 10, "brick_bullet_upgrade.png"))
			brick_placement += 540
		end
		@ball = Ball.new(self)
		@paddle = Paddle.new(self)
	end
	def draw 
		if @score == 2600
			@font.draw("You Win.", 350, 450, 4)
			@font.draw("close the window to play again", 220, 500, 4)
		elsif @lose 
			@font.draw("You Lose.", 340, 450, 4)
			@font.draw("close the window to play again", 220, 500, 4)
		end
		if @bullets.length > 0 
			@bullets.each do |bullet|
				bullet.draw
			end
		end
		@font.draw(@score.to_s, 20, 20, 3)
		@layer_1_brick_array.each do |brick|
			brick.draw
		end
		@layer_2_brick_array.each do |brick|
			brick.draw
		end
		@layer_3_brick_array.each do |brick|
			brick.draw
		end
		@layer_4_brick_array.each do |brick|
			brick.draw
		end
		@power_up_brick.each do |brick|
			brick.draw
		end
		@big_brick.draw
		@background.draw
		@ball.draw
		@paddle.draw
	end
	def update
		@ball.move
		if @score == 2600
			@ball.ending
		end
		if @ball.y > 600
			@lose = true 
			@ball.ending
		end
		if @bullets.length > 0 
			@bullets.each do |bullet|
				bullet.move
			end
		end
		@bullets.each do |bullet|
			if bullet.y < 0 
				@bullets -= [bullet] 
			end
		end
		@bullets.each do |bullet| # ---------------------
			@layer_1_brick_array.each do |brick|
				if are_touching?(bullet, brick)
					@bullets -= [bullet] 
					brick.collision
					@score += 80
				end
			end
			@layer_2_brick_array.each do |brick|
				if are_touching?(bullet, brick)
					@bullets -= [bullet] 
					brick.collision
					@score += 40
				end
			end 
			@layer_3_brick_array.each do |brick|
				if are_touching?(bullet, brick)
					@bullets -= [bullet] 
					brick.collision
					@score += 20
				end
			end 
			@layer_4_brick_array.each do |brick|
				if are_touching?(bullet, brick)
					@bullets -= [bullet] 
					brick.collision
					@score += 10
				end
			end 
			@power_up_brick.each do |brick|
				if are_touching?(bullet, brick)
					@bullets -= [bullet] 
					brick.collision
					@score += 50
				end
			end
			if are_touching?(bullet, @big_brick)
				@bullets -= [bullet] 
				@big_brick.collision
				@score += 550
			end
		end
		if button_down?(Gosu::KbA)
			@paddle.move_left
		end
		if button_down?(Gosu::KbD)
			@paddle.move_right
		end
		if button_down?(Gosu::KbP)
			@ball.randd
		end
		#if button_down?(Gosu::KbSpace) # --------------
		#	print "space"
		#	shot = @paddle.shoot
		#	if shot 
		#		@bullets.push(Bullet.new(self, @paddle.x+30, @paddle.y))
		#		shot = false
		#	end
		#end
		#if button_up?(Gosu::KbSpace)  # ---------------
			#@paddle.reset_shoot
		#end
		if are_touching?(@ball, @paddle)
			@ball.bounce
		end
		@layer_1_brick_array.each do |brick|
			if are_touching?(@ball, brick)
				@ball.bounce
				brick.collision
				@score += 80
			end
		end
		@layer_2_brick_array.each do |brick|
			if are_touching?(@ball, brick)
				@ball.bounce
				brick.collision
				@score += 40
			end
		end
		@layer_3_brick_array.each do |brick|
			if are_touching?(@ball, brick)
				@ball.bounce
				brick.collision
				@score += 20
			end
		end
		@layer_4_brick_array.each do |brick|
			if are_touching?(@ball, brick)
				@ball.bounce
				brick.collision
				@score += 10
			end
		end
		@power_up_brick.each do |brick|
			if are_touching?(@ball, brick)
				@ball.bounce
				brick.collision
				@paddle.upgrade
				@score += 50
			end
		end
		if are_touching?(@ball, @big_brick)
			@ball.bounce
			@big_brick.collision
			@score += 550
		end
	end
	def button_down(id)
		if @lose == false
		if id == Gosu::KbSpace
			shot = @paddle.shoot
			if shot 
				@bullets.push(Bullet.new(self, @paddle.x+30, @paddle.y))
				shot = false
			end
		end
		end
		if @lose == true
		if id == Gosu::KbL
			@lose = false
			@ball.start
		end
		end
	end
	def are_touching?(obj1, obj2)
		obj1.x > obj2.x - obj1.width and obj1.x < obj2.x + obj2.width and obj1.y > obj2.y - obj1.height and obj1.y < obj2.y + obj2.height
	end
end

class Ball
	attr_reader :x, :y, :width, :height
	def initialize(the_window) # the argument here is where the ball goes 
		@x = rand(100..680) # x location form the top left 
		@y = rand(380..480) # relative ot the top left 
		@width = 20 
		@height = 20
		@speed_up = 0
		@x_velocity = rand(3..5) * rand(-1..1) 
		while @x_velocity == 0 
			@x_velocity = rand(3..5) * rand(-1..1) 
		end
		@y_velocity = -5
		@image = Gosu::Image.new(the_window, "ball.png") # the arguments here are where and then what
	end
	def start 
		@x_velocity = rand(3..5) * rand(-1..1) 
		while @x_velocity == 0 
			@x_velocity = rand(3..5) * rand(-1..1) 
		end
		@y_velocity = -5
	end
	def move
		@x = @x + @x_velocity # this changes horzontal location
		@y = @y + @y_velocity # same for vertical location
		if @x > 780 
			@x_velocity *= -1 
		elsif @x < 0 
			@x_velocity *= -1
		end
		if @y < 0
			@y_velocity *= -1
		#elsif @y > 580 
		#	@y_velocity *= -1
		end
	end
	def draw  
		@image.draw(@x, @y, 2) # x coordinate , y coordinate, depth of image(z coordinate)
	end
	def randd
		@x = rand(10..770)
		@y = rand(10..570)
	end
	def bounce
		@y_velocity *= -1
	end
	def ending
		@x = 390
		@y = 290 
		@x_velocity = 0
		@y_velocity = 0
	end
end

class Paddle
	attr_reader :x, :y, :width, :height
	def initialize(the_window)
		@x = 370
		@y = 560 
		@width = 60 
		@height = 20 
		@shoot = 0
		@shoot_true = false
		@the_window = the_window
		@image = Gosu::Image.new(the_window, "paddle.png")
	end
	def draw 
		@image.draw(@x, @y, 1)
	end 
	def move_left
		if @x > 0
			@x -= 10
		end
	end
	def move_right
		if @x < 740
			@x += 10
		end
	end
	def shoot 
		if @shoot_true == true
			return true
		end
	end
	def upgrade
		if @shoot_true == false
			@image = Gosu::Image.new(@the_window, "shooting_paddle.png")
			@shoot_true = true
		end
	end
end

class Brick
	attr_reader :x, :y, :width, :height
	def initialize(window, x, y, image)
		@x = x 
		@y = y 
		@width = 60 
		@height = 40
		@image = Gosu::Image.new(window, image)
	end
	def draw 
		@image.draw(@x, @y, 1)
	end
	def collision
		@x = -200
		@y = -200 
	end
end

class Big_brick
	attr_reader :x, :y, :width, :height
	def initialize(window, x, y, image)
		@x = x 
		@y = y 
		@width = 120 
		@height = 80
		@image = Gosu::Image.new(window, image)
	end
	def draw 
		@image.draw(@x, @y, 1)
	end
	def collision
		@x = -200
		@y = -200 
	end
end
=begin
@bullets.each do |bullet|
	if
		@bullets -= [bullet]
=end
class Bullet 
	attr_reader :x, :y, :width, :height
	def initialize(window, x, y)
	@x = x 
	@y = y 
	@width  = 7 
	@height = 14
	@x_velocity = 0 
	@y_velocity = 15 
	@image = Gosu::Image.new(window, "bullet.png")
	end
	def draw 
		@image.draw(@x, @y, 2)
	end
	def move 
		@y -= @y_velocity
	end
end

class Background
  def initialize(the_window)
    @path = "./breakout_background.jpg"
    @x = 0
    @y = 0
    @background = Gosu::Image.new(the_window, @path)
  end

  def draw
    @background.draw(@x, @y, -1)
  end
end

play = true
while play
window = GameWindow.new
window.show
end


