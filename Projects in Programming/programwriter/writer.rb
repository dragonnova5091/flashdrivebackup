#require "program.txt"

class Choseprint
	attr_reader :printings
	def initialize
		@printings = IO.readlines('printings.txt')
	end
	
	def add_variable
		
		new_v_arr = IO.readlines("dictionary.txt")
		new_v = new_v_arr[rand(0.. new_v_arr.length-1)].chomp
		
		new_v = "#{new_v}\n"
		@printings.push(new_v)
		file = File.open("printings.txt", "w")
		@printings.each do |line|
			file.syswrite(line)
		end
		file.close
	end
end

class Writer
	def initialize
		@choseprint = Choseprint.new
	end 
	
	def write(change)
		text = IO.readlines("program.txt")
		file = File.open("program.txt", "w+")
		
		if rand < 0.3
			@choseprint.add_variable
		end
		
		case change 
			when 1
				if text.length > 5 
					text[rand(0..text.length-1)] = ""
				end
			when (2..5)
				num = rand(0..text.length-1)
				line = text[num]
				line = "#{line} #{(@choseprint.printings[rand(0..@choseprint.printings.length-1)]).chomp}"
				text[num] = line 
			when (6..8)
				num = rand(0..text.length-1)
				line = text[num]
				splitline = line.split(" ")
				if splitline.length > 0
					num2 = splitline[rand(0..splitline.length-1)]
					splitline.delete(num2)
				else 
					line = "#{line} #{(@choseprint.printings[rand(0..@choseprint.printings.length-1)]).chomp}"
				end
			when 9 
				text.insert(rand(0..text.length-1), "\n")
			when 10
				text.insert(rand(0..text.length-1), (@choseprint.printings[rand(0..@choseprint.printings.length-1)]).chomp)
		end
		
		text.each do |line|
		file.syswrite(line)
		#file.syswrite("\n")
		end
		
		
		file.close
	end 
	
	def read
	end
	
	def run
		system("type program.txt")
	end 
end

writer = Writer.new 

10000.times do 
begin
	writer.write(rand(1..10))
	writer.run
rescue
	a = true
else 
	a = false
end
end
puts "end of test"



