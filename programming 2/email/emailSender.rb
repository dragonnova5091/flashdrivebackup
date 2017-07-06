 require 'mail'
 
 mail = Mail.new do 
	from 'esnakemaster1@gmail.com'
	to 'esnakemaster1@gmail.com'
	subject 'test'
	body 'this is the body of the test'
 end
 
mail.delivery_method :sendmail
mail.deliver