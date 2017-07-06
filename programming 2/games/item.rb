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