#Dice Roller
old_count = 1 
old_sides = 6
while true


sides = "asd" 
while sides != 4 && sides != 6 && sides != 8 && sides != 10 && sides != 12 && sides != 20 && sides != 100 && sides != ""
	print "sides on dice, 4, 6, 8, 10, 12, 20, or 100 :> "
	sides = gets.chomp
	if sides == ""
		sides = old_sides
	else 
		sides = sides.to_i
		old_sides = sides 
	end
	
end

 
print "times to roll: :> "
count = gets.chomp
if count == ""
	count = old_count
else	
	count = count.to_i
	old_count = count 
end

roll = []
count.times do 
	roll << rand(1..sides)
end 
puts "your rolls are :"
print roll.sort

sleep 1 

gets



end