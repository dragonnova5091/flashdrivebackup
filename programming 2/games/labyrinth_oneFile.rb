class Number_puzzle
	attr_reader :name
	def initialize(num, lim)
		@guess_num = rand(1..num)
		@limit = lim
		@name = "Number Guessing Game"
	end
	
	def guess 
		@running = true
		print "guess a number beteen 0 and 100.\nyou have only seven tries\n"
#		if @guess == @guess_num
#			return true
#		end
		while @running
		print "   >: "
		@guess = gets.chomp.to_i
		case 
			when @guess == @guess_num || @guess == 777
				return true
				@running = false
				puts "you got it"
			when @guess > @guess_num
				puts "the number is lower"
			when @guess < @guess_num
				puts "the number is higher"
		end
		@limit -= 1
		if @limit <= 0 && @running == true
			return false
		end
		end
	end
end

class Riddle
	attr_reader :name
	def initialize
		@riddles = ["The more you take, the more you leave behind. What am I?", 
		"what dies the moment you say its name?",
		"You can always find me in the past. I can be created in the present, 
but the Future can never taint me. What am I?",
		"I don't have eyes, but once did I see. Once i had thoughts, but now I'm pale and empty.",
		"What always runs but never walks, often murmurs, never talks, 
has a bed but never sleeps, has a mouth but never eats",
		"All about, but cannot be seen, can be captured, cannot be held, No throat, but can be heard"]
		@riddles_answers = ["steps", "silence", "history", "skull", "river", "wind"]
		@name = "Riddle"
		@num = rand(0..5)
	end
	def guess
		
		puts @riddles[@num]
		print ">: "
		ans = gets.chomp
		if ans.include? "#{@riddles_answers[@num]}"
			return true
		else
			return false
		end
	end
end 



class Player
	attr_reader :level, :hp, :inventory, :weapon, :armor, :name, :hp_Max, :experience
	def initialize(name)
		@name = name 
		@level = 0
		@inventory = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
		@hp = 10 
		@hp_Max = 10
		@weapon = Item.new(0, 1)
		@armor = Item.new(0, 2)
		@experience = 0
	end
	
	def gain_xp(xp)
		@experience += xp
		if @experience > @level * 10 
			level_up
		end
	end
	
	def use_potion(name)
		use = false 
		num = 0 
		@inventory.each do |item|
			if item != nil 
				if name.include?(item.name) && use == false 
					@hp += item.attr[0]
					puts "you are healed"
					if @hp > @hp_Max
						@hp = @hp_Max
					end
					puts "your health is at #{@hp}"
					
					@inventory[num] = nil
					use = true
				end
				num += 1 
			end
		end
		if use == false
			puts "you don't have that item"
		end
	end
	
	def level_up
		@experience -= (@level * 10)
		@level += 1 
		@hp_Max += @level * 10
		@hp = @hp_Max
		puts "You Leveled Up!"
	end
	
	def take_dmg(dmg)
		dmg_take = dmg - @armor.attr[0]
		if dmg_take < 0 
			dmg_take = 0
		end
		@hp -= dmg_take
	end	
	
	def drop_item(name)
		tr = false 
		a = 0 
		@inventory.each do |item|
			if item != nil
				if item != @weapon && item != @armor
					if item == name 
						tr = true 
						@inventory[a] = nil 
						puts "dropped"
					end
					a += 1
				else 
					puts "you can't drop an equipped item"
				end
			end
		end
		if tr == false 
			return false
		end
	end
	
	def take_item(item)
		num = check_inventory
		
		if num != false
			@inventory[num] = item
		end
		#print inventory
	end
	

	def display_inventory
		puts "your inventory includes"
		@inventory.each do |item|
			if item != nil 
				puts "	#{item.name} --> #{item.attr}"
			end
		end
		print "\n"
	end
	
	def check_inventory
		tr = false
		a = 0
		b = nil
		@inventory.each do |item|
			if item == nil && tr == false
				tr = true
				b = a 
			else
				a += 1
			end
		end
		if tr 
			return b
		elsif tr == false 
			puts "no free inventory space"
			return false
		end
	end
	
	def equip(item)
		case item.type
			when "sword"
				puts "equipped"
				@weapon = item
			when "armor"
				puts "equipped"
				@armor = item
			else 
				puts "you can't equip that"
		end
	end
	
	def stats
		puts "level: #{@level}"
		puts "experience: #{@experience}"
		puts "hp: #{@hp}"
		puts "hp maximum: #{@hp_Max}"
		puts "weapon: #{@weapon.name} --> #{@weapon.attr}"
		puts "armor: #{@armor.name} --> #{@armor.attr}"
	end 
	
	def die
		@hp = 0
	end
	
	def load_game(weapon, armor, inventory, hp, hp_max, level, experience)
		@weapon = weapon
		@armor = armor
		@inventory = inventory
		@hp = hp 
		@hp_Max = hp_max
		@level = level
		@experience = experience
	end
end

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

class Item
	attr_reader :name, :attr, :tier, :type
	def initialize(tier, type)
		@type = type
		# types are --> 1: weapon 2: armor 3: potion
		
        @tiers = {
            '1' => {'0' => "iron", '1' => "very weak"},
            '2' => {'0' => "steel", '1' => "weak"},
			'3' => {'0' => "orcish", '1' => "medium"},
			'4' => {'0' => "elvish", '1' => "strong"},
			'5' => {'0' => "dwarvish", '1' => "very strong"},
			'6' => {'0' => "demonic", '1' => "ultra strong"},
			'7' => {'0' => "draconic", '1' => "ultimate"},
			'8' => {'0' => "", '1' => ""}
            }
		
		@tier = tier
		if @tier == 0
			case @type
				when 1
					@attr = [0, "dmg"]
					@name = "fists"
					@type = "fists"
				when 2 
					@attr = [0, "def"]
					@name = "shirt"
					@type = "clothes"
			end
		end
		
		case @type 
			when 1 # weapon
				@attr = [(@tier * (@tier * 2)) + rand(0..@tier), "dmg"]
				@name = @tiers["#{@tier}"]['0'] + " sword"
				@type = "sword"
			when 2 # armor 
				@attr = [2*(@tier*(@tier)) + rand(0..@tier), "def"]
				@name = @tiers["#{@tier}"]['0'] + " armor"
				@type = "armor"
			when 3 # potion
				@attr = [15 * @tier, "hp"]
				@name = @tiers["#{@tier}"]['1'] + " potion"
				@type = "potion"
		end
		
	end
	
	def change_name(name)
		@name = name
	end
	
	def change_attr(attr)
		@attr[0] = attr
	end
end

class Enemy
	attr_reader :name, :hp, :damage, :tier, :call
	def initialize(tier)
		@names = {
			"1" => ["giant rat", "rabid dog", "giant cockroach"],
			"2" => ["skeleton", "zombie", "giant spider"],
			"3" => ["wraith", "troll", "cave bear"],
			"4" => ["ghost warrior", "golem", "gorgon"],
			"5" => ["golem warrior", "giant", "vampire wizard"],
			"6" => ["Dragon", "Giant Warrior", "Titan Serpent"]
		}
		@calls = {
			"1" => ["rat", "dog", "cockroach"],
			"2" => ["skeleton", "zombie", "spider"],
			"3" => ["wraith", "troll", "bear"],
			"4" => ["ghost", "golem", "gorgon"],
			"5" => ["golem", "giant", "vampire"],
			"6" => ["dragon", "giant", "serpent"]
		}
		@uplevel_name1 = "Jack,  Tiamat,  Arachne,  Treau,  Meada,  Guraak,  Harkov,  Kongur,  Fluffy,  Titania,  Kuroov,  Nyartholtep,  Borborgymos,  Emeria,  Morgul,".split("  ")
		@uplevel_name2 = "the Poisoned One  the Extinguisher  the Flaming One  the Lord of Death  the Bringer of the Dark  the Returned  the Source of Fear  the Soul Stealer  the Endbringer  Lord of Hell  the Enraged  the Butcher  the King".split("  ")
		@tier = tier
		if @tier != 0 && @tier < 7
		num = rand(0..2)
		@name = @names["#{@tier}"][num]
		@call = @calls["#{@tier}"][num]
		elsif @tier >= 7 
			@name = @uplevel_name1[rand(0..@uplevel_name1.length-1)] + " " + @uplevel_name2[rand(0..@uplevel_name2.length-1)]
			ca = @name.split(",")
			@call = ca[0].downcase
		end
		@hp = @tier * (@tier * 10)
		@damage = @tier * (@tier * 2)
	end
	def attack
		attack = rand(@damage-@tier.to_i..@damage+@tier.to_i)
		return attack
	end
	def take_dmg(dmg)
		take = (dmg - (rand(0..@tier) * 2))
		if take < 0 
			take = 0 
		end
		@hp -= take
		if @hp <= 0 
			return false
		else 
			return true
		end
	end
	
	def change_name(name)
		@name = name 
	end
	def change_call(call)
		@call = call 
	end
	
	def change_atk(dmg)
		@damage = dmg 
	end
	
	def change_hp(hp)
		@hp = hp 
	end
end


class Room
	attr_reader :exit_str, :enemy, :puzzle, :item, :adj
	def initialize(player_level, dir)
		@adjectives = "rocky  dark  large  small  red  orange  yellow  green  blue  purple  black  white  gray  circular  warm  cold  hot  clean  dirty  claustrophobic".split("  ")
		@adj = @adjectives[rand(0..@adjectives.length-1)]
		@enemy = nil
		@item = nil 
		@puzzle = nil 
		@room_type = true 
		
		num = rand(0..11)
		#num = 15 #--
		if num == 10
			num = rand(1..8)
			@description = ""
			#num = 3 #--
			case num
				when 1 
					@room_type = num 
					tree_room 
				when 2 
					@room_type = num 
					bone_pile(player_level)
				when 3 
					@room_type = num 
					fire_room
				when 4
					@room_type = num 
					arena
				when 5 
					if player_level >= 7 
						@room_type = num 
						mountain
					else 
						@room_type = true
					end
				when 6 
					throne
					@room_type = num 
				when 7 
					@room_type = num 
					battleground
				when 8 
					@room_type = num 
					slime
			end
		end
		
		#exits N E S W = 1 2 3 4 
		exits = []
		rand(1..4).times do
			exits.push(rand(1..4))
		end
		case dir
			when 1 	
				exits.push(3)
			when 2 
				exits.push(4)
			when 3 
				exits.push(1)
			when 4 
				exits.push(2)
		end
		exits = exits.uniq.sort()
		while exits.length <= 1 
			rand(2..4).times do
				exits.push(rand(1..4))
				exits = exits.uniq.sort()
			end
		end

		@exit_str  = ""
		
		exits.each do |ex|
		case ex
			when 1 
				@exit_str += "North "
			when 2 
				@exit_str += "East "
			when 3 
				@exit_str += "South "
			when 4 
				@exit_str += "West "
		end
		end
		@exit_str += "."
		
		if @room_type == true 
			num = []
			rand(1..4).times do
				num.push(rand(0..3))
			end
			if player_level == 0
				num.push(3)
			end
			num = num.uniq 
			num.each do |number|
				case number
					when 1 
						if player_level != 0
							@enemy = Enemy.new(rand(1..player_level))
						end
					when 2 
						case rand(1..2)
							when 1
								@puzzle = Number_puzzle.new(100, 7)
							when 2
								@puzzle = Riddle.new
						end
					when 3
						a = rand(1..50)
						b = rand(1..3)
						if a == 50
							@item = Item.new(7, b)
						elsif a >= 48
							@item = Item.new(6, b)
						elsif a >= 45 
							@item = Item.new(5, b)
						elsif a >= 41
							@item = Item.new(4, b)
						elsif a >= 37
							@item = Item.new(3, b)
						elsif a >= 30
							@item = Item.new(2, b)
						elsif a >= 20
							@item = Item.new(1, b)
						end
				end
			end
		end
		
		look
	end
	
	def change_room(direction)
		if @puzzle == nil
			if @exit_str.include?(direction)
				return true
			else
				return false
			end
		else 
			puts "you must finish the puzzle first"
		end
	end
	
	def check_enemy
		if @enemy != nil 
			return true 
		else 
			return false
		end
	end
	
	def check_puzzle
		if @puzzle != nil 
			return true 
		else 
			return false
		end
	end
	
	def check_item
		if @item != nil 
			return true 
		else 
			return false
		end
	end
	
	def look
		if @room_type == true 
			puts "you are in a #{@adj} room"
			puts "exits are to the #{@exit_str}"
			it = check_item
			en = check_enemy
			pu = check_puzzle
			
			if it 
				puts "there is a #{@item.name} --> #{@item.attr}"
			end
			if en
				puts "there is a #{@enemy.name} --> #{@enemy.hp} hp"
			end
			if pu 
				puts "there is a #{@puzzle.name}"
			end
		else 
			puts @description
			puts "exits are to the #{@exit_str}"
			if check_enemy
				puts "there is a #{@enemy.name} --> #{@enemy.hp} hp"
			end
			if check_item 
				puts "there is a #{@item.name} --> #{@item.attr}"
			end
		end
	end
	
	def finish_puzzle
		@puzzle = nil
	end
	def take_item
		@item = nil
	end
	def add_item(item)
		@item = item
	end
	def add_enemy(enemy)
		@enemy = enemy	
	end
	def kill_enemy
		if @room_type == true 
			@enemy = nil
		else 
			case @room_type
				when 1 
					@enemy = nil 
					@item = Item.new(7, 2)
				when 2 
					@enemy = nil 
					@item = Item.new(@lvl, 2)
				when 3 
					@enemy = nil 
					@item = Item.new(6, 1)
				when 4
					if @times <= 0 
						@enemy = nil 
						@item = Item.new(8, 1)
						@item.change_name("Giant Hammer")
					else
						@times -= 1 
						num = rand(5..6)
						case num 
							when 5 
								@enemy = Enemy.new(5)
								@enemy.change_name("giant")
								@enemy.change_call("giant")
							when 6 
								@enemy = Enemy.new(6)
								@enemy.change_name("Giant Warrior")
								@enemy.change_call("giant")
						end
					end
				when 5
					@enemy = nil 
					@item = Item.new(8,2)
					@item.change_name("World Eater Armor")
				when 6 
					@enemy = nil 
					@item  = nil
					puts "Congratulations, you just won the game."
					puts "type stop game to stop the game"
				when 7 
					if @times <= 0 
						@enemy = nil 
						@item = Item.new(7, rand(1..2))
					else 
						@times -=1 
						@enemy = Enemy.new(6)
					end
				when 8
					@enemy = nil
					@item = Item.new(8, 3)
					@item.change_name("Divine Potion")
			end
		end
	end
	
	# --------------------------------------
	#special rooms 
	
	def tree_room #1
		@enemy = Enemy.new(7)
		@description = "you are in a room different from \nthe other rooms that you normally are in.\n there is a giant tree that towers above you."	
	end
	
	def bone_pile(pl_lvl) #2
		@lvl = pl_lvl + 2 
		@enemy = Enemy.new(@lvl)
		@description = "you are in a strange room\na pile of bones sits in the middle\nand the walls are covered in deep gouges"
	end
	
	def fire_room #3
		@enemy = Enemy.new(6)
		@enemy.change_name("Fire Elemental")
		@enemy.change_call("elemental")
		@description = "you are in a firey room, \nthe walls are red from the heat and\nthere is pits filled with molten metal"
	end
	
	def arena #4
		@times = 5
		num = rand(5..6)
		case num 
			when 5 
				@enemy = Enemy.new(5)
				@enemy.change_name("giant")
				@enemy.change_call("giant")
			when 6 
				@enemy = Enemy.new(6)
				@enemy.change_name("Giant Warrior")
				@enemy.change_call("giant")
		end
		@description = "you are in a giant arena\nit is similar to a roman colluseum \nthe ground is sand and bones have been scattered around."
	end
	
	def mountain #5
		@enemy = Enemy.new(8)
		@enemy.change_name("Alduin, Bane of Worlds")
		@enemy.change_call("alduin")
		@description = "you are in a open topped room\nthe room itself is littered with\nthe corpses of the dead."
	end
	
	def throne #6
		@enemy = Enemy.new(1)
		@enemy.change_name("Ashinek, the King")
		@enemy.change_call("ashinek")
		@enemy.change_hp(500)
		@enemy.change_atk(500)
		@description = "you are in a big room with a throne\nthe walls are covered in paintings of glory\nand blood."
	end
	
	def battleground #7
		@enemy = Enemy.new(6)
		@times = 2 
		@description = "you are in what seems to be a battle ground\nthe corpses are piled high\nand the ground is stainded red."
	end
	
	def slime #8
		@enemy = Enemy.new(1)
		@enemy.change_atk(110)
		@enemy.change_hp(1500)
		@enemy.change_name("The Ooze")
		@enemy.change_call("ooze")
		@description = "the room seeems to be covered in a green slime\nthis slime drips from the ceiling\nand rolls down the walls\nit is truly disgusting."
	end
	
	#cheats 
	def special_room(player_level)
		num = rand(1..8)
			@description = ""
			#num = 3 #--
			case num
				when 1 
					@room_type = num 
					tree_room 
				when 2 
					@room_type = num 
					bone_pile(player_level)
				when 3 
					@room_type = num 
					fire_room
				when 4
					@room_type = num 
					arena
				when 5 
					if player_level >= 7 
						@room_type = num 
						mountain
					else 
						@room_type = true
					end
				when 6 
					throne
					@room_type = num 
				when 7 
					@room_type = num 
					battleground
				when 8 
					@room_type = num 
					slime
			end
	end
end

