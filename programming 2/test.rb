array = [1, 2, 3, 4, 5, 6]
array.each do |ar|
	array.push(rand(1..array.length))
	puts ar
	sleep 0.5
end