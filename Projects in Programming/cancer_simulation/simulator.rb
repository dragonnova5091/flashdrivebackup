#this is going to simulate canger with text files(cells) in a folder(body).
MUTATION_RATE = 0.01
$time_start = Time.new

TIME_TO_DEATH = 5
VISIBLE = true 
MITOSIS_AT = 5
class Body
	def initialize
		#print Dir.glob("**")
		for file in Dir.glob("**")
			if file == "body"
				Dir.chdir file
			end
		end
		puts Dir.pwd
		
		if Dir.glob("*/.txt").length == 0 
			10.times do 
				
			end
		end
		
	end
	
	def update
	
	end
	
	def check
	
	end
	
	def mutate
	
	end
	
	def mitosis
	
	end 
	
	def cleanup
	
	end
	
end


body = Body.new
#body.read
body.update

sleep 8