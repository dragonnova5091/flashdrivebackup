#number sorter

array1 = "5 3 7 4 9 7 3 9 7 5 5 6 7 6 2 4 7 7 8 8 3 6 2 7 9 6 7 8 2 6 8 3 5 1 3 6 9 2 4 6 1 2 3 1 3 4 1 5 10 4 2 1 4 6 1 1 9 5 3 4 7 9 6 4 1 2 3 2 7 6 4 7 2 3 8 1 2 5 7 4 5 6 6 6 6 1 2 3 3 1 3 5 3 8 2 5 7 4 9 7 9".split(" ")
array2 = "29 84 37 44 50 11 54 75 27 57 45 27 44 25 22 02 14 99 84 56 34 22 91 37 42 79 44 81 18 10 26 18 64 76 93 50 51 52 02 04 06 15 89 91 04 05 06 63 73 09 66 42 69 80 30 09 34 56 92 30 66 87 99 65 21 04 05 06 33 57 77 87 65 29 36 39 27 14 25 99 07 08 09 66 66 66 04 05 06 13 20 03 27 45 67 49 82 37 83 75 43 37".split(" ")
array3 = "275 742 654 444 599 333 666 999 227 895 999 785 727 587 756 002 896 240 386 666 827 475 134 173 209 777 020 082 012 050 600 888 968 432 391 222 444 666 002 004 006 562 794 999 007 008 009 699 282 110 666 420 696 886 390 013 194 392 175 543 798 199 679 513 613 007 008 009 187 223 771 567 432 981 643 937 043 017 111 725 100 150 666 666 666 007 008 1000 009 313 004 020 434 367 897 753 624 387 621 273 389 967".split(" ")

a = 0 
array1.each do |num|
	array1[a] = num.to_i
	a += 1 
end

a = 0 
array2.each do |num|
	array2[a] = num.to_i
	a += 1 
end

a = 0 
array3.each do |num|
	array3[a] = num.to_i
	a += 1 
end

array1.sort!
array2.sort!
array3.sort!


print array1
print "\n"
print array2
print "\n"
print array3

gets

file = File.open("sorted_numbers.txt", "w+")
priornum = -1 
array1.each do |num|
	if num != priornum
		file.syswrite("\n")
		file.syswrite(num)
	else 
		file.syswrite(" #{num}")
	end
	priornum = num 
end
file.syswrite("\n")
file.syswrite("--" * 10)

array2.each do |num|
	if num != priornum
		file.syswrite("\n")
		file.syswrite(num)
	else 
		file.syswrite(" #{num}")
	end
	priornum = num 
end
file.syswrite("\n")
file.syswrite("--" * 10)

array3.each do |num|
	if num != priornum
		file.syswrite("\n")
		file.syswrite(num)
	else 
		file.syswrite(" #{num}")
	end
	priornum = num 
end
file.syswrite("\n")

gets







