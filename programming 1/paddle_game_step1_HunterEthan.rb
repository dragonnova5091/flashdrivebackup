#required programs
require 'gosu'

class Gamewindow < Gosu::Window
	def initialize()
		super(800, 600)
		self.caption = "my pong game"
		
	end
	
	def update 
	end
	
	def draw 
	end
end

#code
window = Gamewindow.new 
window.show