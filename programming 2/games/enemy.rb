require_relative 'player.rb'

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