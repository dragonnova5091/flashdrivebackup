time = Time.new
array = []
10000.times do
	array.push(rand(0..1000))
end
#print array
print "\n"
sorted_array = []
a = true
b = 0
10000.times do
	min = array.min
	sorted_array.push(min)
	while a
		if array[b] == min
			array[b] = 10000
			a = false
		end
		b += 1
	end
	a = true
	b = 0
end
print sorted_array
time2 = Time.new
time3 = time2-time
puts time3
sleep 20
