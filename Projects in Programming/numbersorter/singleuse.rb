#single use program

array = "29 84 37 44 50 11 54 75 27 57 45 27 44 25 22 02 14 99 84 56 34 22 91 37 42 79 44 81 18 10 26 18 64 76 93 50 51 52 02 04 06 15 89 91 04 05 06 63 73 09 66 42 69 80 30 09 34 56 92 30 66 87 99 65 21 04 05 06 33 57 77 87 65 29 36 39 27 14 25 99 07 08 09 66 66 66 04 05 06 13 20 03 27 45 67 49 82 37 83 75 43 37".split(" ")
a = 0 
array.each do |num|
	array[a] = num.to_i
	a += 1 
end
array.sort!

file = File.open("tempfile.txt", "w+")

a= 0 
array2 = []
100.times do 
	array2 << a
end

array.each do |num|
	array2[num-1] += 1 
	puts num
end

array2.each do |num|
	file.syswrite(num)
	file.syswrite("\n")
end

gets