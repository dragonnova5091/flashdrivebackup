puts "hello, im conducting a survey and id like to ask you a few questions."
survey = []
puts "what is your favorite color?"
color = gets.chomp
survey.push(color)
puts "what is your favorite food"
food = gets.chomp
survey.push(food)
puts "which do you prefer: movies, books, or videogames"
hobby = gets.chomp
survey.push(hobby)
puts survey.inspect
survey.clear
puts survey.inspect
survey[0] = "this"
survey[1] = "exercise"
survey[2] = "is"
survey[3] = "boring"
survey.insert(4, "right")
puts survey