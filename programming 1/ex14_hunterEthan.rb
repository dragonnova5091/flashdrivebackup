test_scores = [97, 68, 77, 91, 84, 57, 89, 45, 73, 95]
puts "here is a closer look at the class test scores:\n "
for score in test_scores
	if score >= 90 
		puts "this students received a score of #{score}. there grade is an A"
	elsif score >= 80 
		puts "this students received a score of #{score}. there grade is an B"
	elsif score  >= 70
		puts "this students received a score of #{score}. there grade is an C"
	elsif score >= 60 
		puts "this students received a score of #{score}. there grade is an D"
	else 
		puts "this students received a score of #{score}. there grade is an F"
	end
end 
favorite_foods = ["burgers", "pizza", "steak", "burritos", "tacos", "choclate cake", "ice cream"]
puts "we asked some people about their favorite foods and here are the results:\n "
favorite_foods.each do |food|
	puts "\t" + food 
end 