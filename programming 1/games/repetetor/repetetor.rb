#repetor

def question_line_grab(filename)
	file = IO.readlines(filename)
	file.each do |line|
		if line.include? "?"
			a= 0 # just to fill space
		else 
			line_removal(filename, line)
		end
	end
	
end

def non_question_grab(filename)
	file = IO.readlines(filename)
	file.each do |line|
		if line.include? "?"
			line_removal(filename, line)
		end
	end
end

def line_removal(filename, prob)
	temp = File.new("temp.txt", "w+")
	file = File.open(filename, "w+")
	lines = IO.readlines(filename)
	lines.each do |line|
		if line != prob 
			temp.syswrite(line)
		end
	end
	File.delete(filename)
	File.rename("temp.txt", filename)
end

#question_line_grab("previous_questions.txt")
#non_question_grab("previous_cosas.txt")

words = File.open("previous_cosas.txt", "a+")
ques = File.open("previous_questions.txt", "a+")
talking = true
time = 0

puts "please, when asking a question, use a Question Mark. - ? - 
other than that, have fun with the randomness
-----------------------------------------------------------------------

"

puts "ask me a question:" #question
	ans = gets
while talking
	time += 1
	if time > 5
		puts "you haven't asked a question in a while"
		if ans.include? "?"
		ques.syswrite(ans)
		respond = IO.readlines("previous_cosas.txt") # if question, response
		re = respond[rand(0..respond.length-1)]
		puts re 
		question = IO.readlines("previous_questions.txt") # question
		qu = question[rand(0..question.length-1)]
		puts qu
		time = 0 
		end
	elsif ans.include? "?"
		ques.syswrite(ans)
		respond = IO.readlines("previous_cosas.txt") # if question, response
		re = respond[rand(0..respond.length-1)]
		puts re 
		question = IO.readlines("previous_questions.txt") # question
		qu = question[rand(0..question.length-1)]
		puts qu
		time = 0 
	#elsif time > 5 
	#	question = IO.readlines("previous_questions.txt") # if not question, question asked
	#	qu = question[rand(0..question.length-1)]
	#	puts qu
	#	puts "you haven't ask a question in a while"
	#	time = 0
	elsif ans.include? "bye "
		puts "Goodbye."
		sleep 3
		exit
	else 
		words.syswrite(ans)
		question = IO.readlines("previous_questions.txt") # if not question, question asked
		qu = question[rand(0..question.length-1)]
		puts qu
		
	end
	ans = gets
	question_line_grab("previous_questions.txt")
	non_question_grab("previous_cosas.txt")
end



