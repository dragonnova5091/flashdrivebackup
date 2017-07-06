#ruby tools
print "how big: "
ans = gets.chomp.to_i

array = []
a = 1
ans.times do
  array << a
  a += 1
end

array.shuffle!

a = 1
array.each do |num|
  if a < 10
      print "#{a}  --#{num}\n"
  elsif a <100
      print "#{a} --#{num}\n"
  elsif a < 1000
      print "#{a}--#{num}\n"
  else
      print "#{a}--#{num}\n"
  end
  a+=1
  sleep 10
end

sleep 30
