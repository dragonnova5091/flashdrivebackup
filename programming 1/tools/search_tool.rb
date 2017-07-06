#used for searching all file from one point forward for a specific string

def get_dirs(start_dir)
	Dir.chdir(start_dir)
	files = File.join("**.**")
	fls1 = Dir.glob(files)
	files = File.join("**")
	fls2 = Dir.glob(files)
	fls3 = []
	a = 0 
	while a<= fls2.length
		if fls1[a] != fls2[a]
			#puts fls2
			fls3[fls3.length] = fls2[a]
		end
		a += 1
	end
	return fls3
end

def get_filenames(dir, name, filetype)
	Dir.chdir(dir)
	files = File.join("#{name}.#{filetype}")
	names = Dir.glob(files)
	return names
end

def search_file(filename, search_str)
	contained = []
	lines = IO.readlines(filename)
	lines.each do |line|
		if line.include? search_str
			contained.push(line)
		end
	end
	return contained
end 

def search_dir(dir, search_obj, name, filetype)
found_lines = []
	filenames = get_filenames(dir, name, filetype)
	filenames.each do |file|
		found_lines = search_file(file, search_obj)
	end
	return found_lines
end

#--------------------------------------------------------

print "Start Directory => "
start_dir = gets.chomp
print "Name Constraints => "
name_constrainsts = gets.chomp
print "File Type = > "
file_type = gets.chomp
print "Search String => "
search_str = gets.chomp 

dirs = get_dirs(start_dir)
found = []
dirs.each do |dir|
	found = search_dir(dir, search_str, name_constrainsts, file_type)
end
puts found
#puts dirs
#puts "=>"
#puts get_dirs(start_dir)


