class Automobile
	def initialize(color, name)
		@color = color 
		@name = name
		puts "you havejust created a neew car. its name is #{@name} and its color is  #{@color}"
	end
	def drive()
		puts  "the #{@color} #{@name} is driving forward"
	end
	def reverse() 
		puts  "the #{@color} #{@name} is driving backwards"
	end
end
my_car = Automobile.new("blue", "Ferrari")
my_car.drive 
my_car.reverse
sleep 5