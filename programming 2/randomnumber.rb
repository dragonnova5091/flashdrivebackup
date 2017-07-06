print "type the maximum:> "
max = gets.chomp.to_i
array = []
a = 1 

max.times do 
	array.push(a)
	a += 1
end

array = array.shuffle

array.each do |line|
	puts line 
	#sleep 10
end
puts "done"
sleep 30