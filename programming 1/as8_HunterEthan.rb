class Automobile
	def initialize(color, name, speed, price)
		@color = color 
		@name = name
		@price = price 
		@speed = speed
		puts "you havejust created a neew car. its name is #{@name} and its color is  #{@color}"
	end
	def drive()
		puts  "the #{@color} #{@name} is driving forward at #{@speed} mph"
	end
	def reverse() 
		puts  "the #{@color} #{@name} is driving backwards"
	end
	def doughnuts()
		
		puts "your #{@color} #{@name} is now doing doughnuts"
	end
	def stop()
		puts "the #{@color} #{@name} is now stopped"
	end
	def price 
		puts "the price of the car is $#{@price}"
	end
end
my_car = Automobile.new("blue", "Ferrari", 10, 0)
my_car.drive 
my_car.reverse
car2 =Automobile.new("green", "truck", 35, 2000)
car2.doughnuts
car2.drive
car2.stop
car2.price