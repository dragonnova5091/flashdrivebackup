file = IO.readlines("dictionary.txt")
while true
input = gets.downcase
a = false
file.each do |line|
	if input == line
		puts "is word"
		a = true
	end
end
if a == false
	puts "not word"
end
#print file
end
sleep 10