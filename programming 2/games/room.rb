require_relative 'enemy.rb'
require_relative 'item.rb'
require_relative 'player.rb'

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




