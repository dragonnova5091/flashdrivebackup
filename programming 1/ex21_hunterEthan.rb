require './ex20_HunterEthan.rb'
class Truck < Automobile

def offroad()
puts "I'm putting my truck into 4 wheel drive"
self.drive 
puts "i just ran over your little car"
end 

def reverse()
super()
puts "but now i can use a backup camera to see better"
end 

def park()
puts "my #{@color} #{@name} is now parked"
end
end
my_truck = Truck.new("Red", "Ford 650")
my_truck.drive
my_truck.reverse
my_truck.offroad
my_truck.park

my_cool_car = Automobile.new("Black", "1969 Camaro SS")