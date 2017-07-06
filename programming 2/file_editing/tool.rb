class Origin
	
	def initalize
		dir = false 
		while dir == false 
			puts Dir.pwd
			print "cd "
			chdir = gets.chomp.downcase
			begin
			if  chdir == "dir" || chdir == "ls"
				Dir.glob("**").each do |item|
					puts item
				end
			elsif chdir != ""
				Dir.chdir chdir
			else
				dir = true
			end
			rescue 
				puts "you can't do that"
			end
		end
		#Dir.chdir ""
		print "search string :> "
		@search_string = gets.chomp.downcase
		while @search_string == ""
			puts "the search string can't be blank"
			print "search string :> "
			@search_string = gets.chomp.downcase
		end
		#print "parameters :> "
		#@restrictions = gets.chomp.downcase
		@workingdirectory = Dir.pwd
		puts @workingdirectory
		glob_file(@workingdirectory)
	end
	
	def open_dir(dirname)
		Dir.chdir dirname
		@workingdirectory = Dir.pwd
		glob_file(@workingdirectory)
		Dir.chdir ".."
	end
	
	def glob_file(dir)
		Dir.chdir(dir)
		Dir.glob('**').each do |item|
			if Dir.exist?(item)
				#puts item + "--"
				open_dir(item)
			else
				search_file(item)
			end
		end
	end
	
	def search_file(file_)
		file = IO.readlines(file_)
		tr = true
		num = 1
		file.each do |line|
			if line.include?(@search_string)
				if tr 
					puts @workingdirectory
					puts "    --#{file_}"
					tr = false
				end
					puts "#{num}    #{line}"
			end
			num += 1 
		end
		if tr == false 
			o = gets
		end
	end
	
end
while true
run = Origin.new
run.initalize
puts "--" * 10
end
sleep 50