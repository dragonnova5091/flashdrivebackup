

class Reader
	def initialize(sentence)
		begin
			@meanings = File.open("oldMeanings.txt", "a+")
			@meanings_array = IO.readlines("oldMeanings.txt")
		rescue
			@meanings = File.new("oldMeanings.txt", "a+")
			@meanings_array = IO.readlines("oldMeanings.txt")
		end
		
		#meaning = "P|this is a test"
		
		found = false #used for later testing
		count = 0
		
		#puts "---" + sentence #test
		#puts meanings_array
		
		for line in @meanings_array
			line = line.split(" -- ")
			
			if sentence == line[0]
				found = true
				match = count
				puts "match"
			end
			count += 1
		end
		if found == true
			#puts "match" #test
			puts "@@" + @meanings_array[match]
			meaning = @meanings_array[match]
			respond(meaning)
		else 
			print "I need to learn what to do. Please tell me: "
			meaning = gets.chomp
			@meanings.syswrite("#{sentence} -- #{meaning}\n")
			respond(meaning)
		end
		#if the prior responses are unfindable/a new file was created
		if @meanings_array.length ==0
			
			print "I need to learn what to do. Please tell me: "
			meaning = gets.chomp
			@meanings.syswrite("#{sentence} -- #{meaning}\n")
			
		end
		
		
		#meanings = File.close
	end
	
	def respond(meaning)
		
		meaning = meaning.split("|")
		
		if meaning[0] == "P"
			puts meaning[1]
		end
	end
end

test = Reader.new("test sentence2")

sleep 3