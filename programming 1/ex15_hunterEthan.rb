start_time = Time.new
puts start_time
puts "enter your name: "
name = gets.chomp
end_time = Time.new
time_difference = start_time - end_time
time_difference = time_difference.abs
puts "the time it took you to do that was #{time_difference}"
rounded_time = time_difference.round(2)
puts "we can round that to #{rounded_time}"
