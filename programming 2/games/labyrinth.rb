require_relative 'puzzles.rb'
require_relative 'player.rb'
require_relative 'room.rb'

class Game 
	attr_reader :player
	def initialize(name)
		@player = Player.new(name)
		@rooms = {}
		@rooms["0,0"] = Room.new(@player.level, 0)
		@room = @rooms["0,0"]
		@x = 0 
		@y = 0
		@word = ""
	end
	
	def changeRoom(dir)
		case dir 
			when 1 
				@y += 1 
			when 2 
				@x += 1 	
			when 3 
				@y -= 1 
			when 4 
				@x -= 1
		end
		begin
			@room = @rooms["#{@x},#{@y}"]
			@room.look
		rescue
			@rooms["#{@x},#{@y}"] = Room.new(@player.level, dir)
			@room = @rooms["#{@x},#{@y}"]
		end
	end
	
	def action
		
		print ">: "
		ans = gets.chomp.to_s
		if ans != ""
			@word = ans
		end
		case @word
			when "stop game", "stop" # stop the game
				exit
			when "l" #looking around	
				@room.look
			when "display" # inventory
				@player.display_inventory
			when "no" #funny
				puts "don't be an idiot.\na spear flies out of the wall and impales you in the head."
				@player.die
			when "killjoy" #cheats
				@room.finish_puzzle
			when  "n" #movement
				tr = @room.change_room("North") 
				if tr
					changeRoom(1)
				elsif tr == false  
					puts "that doesn't work"
				end
				#@room = Room.new(@player.level)
			when  "e" #movement
				tr = @room.change_room("East")
				if tr 
					changeRoom(2)
				elsif tr == false  
					puts "that doesn't work"
				end
				#@room = Room.new(@player.level)
			when  "s" #movement
				tr = @room.change_room("South")
				if tr 
					changeRoom(3)
				elsif tr == false  
					puts "that doesn't work"
				end
				#@room = Room.new(@player.level)
			when  "w" #movement
				tr = @room.change_room("West")
				if tr 
					changeRoom(4)
				elsif tr == false  
					puts "that doesn't work"
				end
				#@room = Room.new(@player.level)
			when "help"
				puts "possible commands:
move + 'direction' --> move towards the indicated direction 
look around --> describes the room 
guess a number --> start the number guessing game 
answer a riddle --> answer the riddle 
stats --> display the statistics
open inventory --> displays your inventory
attack + 'enemy name' --> attacks the enemy
equip + 'item name' --> equip the indicated item
attack + 'full enemy name' --> attack indicated enemy
take + 'item name' --> take the indiacted item"
			when "clear", "cls"
				system('cls')
				@room.look
			when "stats" #statistics 
				@player.stats
			when "i" #inventory display
				@player.display_inventory
			when "clean room"
				if @room.adj == "dirty"
					puts "you clean the room, it's still dirty"
				end
			#cheats
			when "godmode-passcode-5091"
				num = rand(1..2)
				@room.add_item(Item.new(7, num))
				@room.look
			when "godmode-passcode-5092"
				@room.add_enemy(Enemy.new(6))
				@room.look
			when "godmode-passcode-5093"
				5.times do
					@player.gain_xp(@player.level * 10)
				end
			when "godmode-passcode-5094"
				@room.special_room(@player.level)
				@room.look
			when "godmode-passcode-5095"
				item = Item.new(1, 1)
				item.change_name("Finger Gun")
				item.change_attr(9999999)
				@player.equip(item)
				item = Item.new(1, 2)
				item.change_name("Putin's Vest")
				item.change_attr(9999999)
				@player.equip(item)
		end
			#take items 
		case 
			when @word.include?("take ")|| @word.include?("grab ")|| @word.include?("pick up ")
				if @room.check_item
					if @word.include?(" #{@room.item.name.downcase}") || @word.include?(" #{@room.item.type}")
						puts "taken"
						if @player.level == 0 && @room.item.type == "sword"
							@player.gain_xp(@room.item.tier)
							@player.take_item(@room.item)
							@room.take_item
						elsif @player.level == 0 && @room.item.type != "sword"
							@player.take_item(@room.item)
							@room.take_item
						elsif @player.level != 0 
							@player.take_item(@room.item)
							@player.gain_xp(@room.item.tier)
							@room.take_item 
						end
					end
				else
					puts "that item is not here"
				end
			
			when @word.include?("drop ") || @word.include?("leave ")
				@player.inventory.each do |item|
					if item != nil 
						if @word.include?(" #{item.name}")
							@player.drop_item(item)
							@room.add_item(item)
						end
					end
				end
			
			when @word.include?("attack "), @word.include?("hit ")
				if @room.check_enemy
					if @word.include?(" #{@room.enemy.call}")
						combat 
					else 
						puts "you can't hit that"
					end
				else 
					puts "there is not enemy"
				end
			when @word.include?("look")
				@room.look
				
			when @word.include?("use ") || @word.include?("drink ")
				if @word.include?(" potion")
					@player.use_potion(@word)
				end
				
			when @word.include?("move ")|| @word.include?("go ")|| @word.include?("walk ")
				if @word.downcase.include?("north")
					tr = @room.change_room("North")
					if tr 
						changeRoom(1)
					elsif tr == false 
						puts "that doesn't work"
					end
				elsif @word.downcase.include?("east")
					tr = @room.change_room("East")
					if tr 
						changeRoom(2)
					elsif tr == false  
						puts "that doesn't work"
					end
				elsif @word.downcase.include?("south")
						tr = @room.change_room("South")
					if tr 
						changeRoom(3)
					elsif tr == false  
						puts "that doesn't work"
					end
				elsif @word.downcase.include?("west")
					tr = @room.change_room("West")
					if tr 
						changeRoom(4)
					elsif tr == false  
						puts "that doesn't work"
					end
				end
				
			when @word.include?("answer") || @word.include?("guess") || @word.include?("number") || @word.include?("riddle") || @word.include?("puzzle")
				if @room.check_puzzle
					tr = @room.puzzle.guess 
					if tr 
						@room.finish_puzzle
						puts "correct"
						if @player.level != 0
							@player.gain_xp(5)
						end
					else
						puts "a spear flies out of the wall!"
						time1 = Time.new
						puts "to dodge press space bar twice then press enter!"
						chance = gets.chomp 
						time2 = Time.new
						time3 = time2 - time1
						if chance == "  " && time3 <= 3
							puts "you dodged it." 
						else
							@player.die
							puts "you were to slow, the spear impales you in the head"
						end
					end
				else 
					puts "there is no puzzle"
				end 
				
			when @word.include?("open ") || @word.include?("display ") || @word.include?("look at ")
				if @word.include?(" inventory")
					@player.display_inventory
				end
				
			when @word.include?("equip ")
				b = true 
				@player.inventory.each do |item|
					if item != nil
						if @word.include?(" #{item.name}")
							@player.equip(item)
							b = false 
						end
					end
				end
				if b == true
					puts "you don't have that item."
				end
			#else 
			#puts "type help for possible commands"
		end
	end
	
	def combat
		if @player.weapon.name == "Finger Gun"
			puts "\n        PEW\n\n"
		end
		puts "you hit the #{@room.enemy.name}"
		live = @room.enemy.take_dmg(@player.weapon.attr[0])
		puts "the #{@room.enemy.name} has #{@room.enemy.hp} hp"
		if live 
			dmg_take = @room.enemy.damage - @player.armor.attr[0]
			if dmg_take < 0 
				dmg_take = 0
			end 
			puts "the #{@room.enemy.name} attacks"
			puts "you take #{dmg_take}"
			@player.take_dmg(@room.enemy.damage)
			if @player.hp <= 0
				puts "you died."
			else 
				puts "you have #{@player.hp} hp"
			end
		elsif live == false 
			puts "the #{@room.enemy.name} died"
			@player.gain_xp(5 * @room.enemy.tier)
			@room.kill_enemy
		end
	end
end

puts "enter your name below:"
name = gets.chomp

puts "as you walk down the street, you come across a glowing purple portal,"
puts "it calls to you: #{name}...   come to me... we have awaited you."
puts "do you enter the portal?"
print ">: "
ans = gets.chomp

if ans.downcase.include?("yes") || ans.downcase == "y"
puts "you walk into the portal, a flash of light, a feeling of vertigo,"	
puts "and a painful burst of heat, you awake inside a labyrinth of rooms...\n\n"

game = Game.new(name)
while game.player.hp > 0
	game.action
end

else 
	puts "you pass the portal and go on with your boring pointless excistence"
end
#room = Room.new("o", 5)