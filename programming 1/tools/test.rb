#puts Dir.pwd
Dir.chdir("E:/ruby programs/games")
rbfiles = File.join("**.**")#, "*.**")
fls1 = Dir.glob(rbfiles)
puts fls1
puts "__" * 30

rbfiles = File.join("**")#, "*.**")
fls2 = Dir.glob(rbfiles)
puts fls2
puts "__" * 30

fls3 = []
a = 0 
while a<= fls2.length
	if fls1[a] != fls2[a]
		#puts fls2
		fls3[fls3.length] = fls2[a]
	end
	a += 1
end
 puts fls3

'files = Dir.glob(rbfiles)
files.each do |filename|
	if filename.include? "asrfes"
		file = IO.readlines(filename)
		file.each do |line|
			if line.include? "puts"
				puts line
			end
		end
	end
end
puts'
sleep 3