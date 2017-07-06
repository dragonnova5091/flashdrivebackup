require_relative 'Item.rb'

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
