require 'gosu'
class OpenWindow < Gosu::Window
	def initialize
		super(800, 600)
		self.caption = 'hello'
		
	end
end
window = OpenWindow.new
window.show