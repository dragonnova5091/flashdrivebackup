=begin
	Re-imprison the three.
		- by Ethan R. Hunter
	tested by 
		- Garrett Kawaguchi
		-
		-
=end
# FUNCTIONS ----------------------------------------------------------------------------------------------------
def user_choice(choices)
b = 1
	puts "What do you do?"
	choices.each do |choice|
		puts "    #{b}. " + choice
		b += 1
	end
	input = check_number
	return input
end
#--------------------------------
def check_number()
	check = true
	while check
		input = gets.chomp
		test = input
		input = input.to_i
		input = input.to_s
		if input == test
			check = false
			input = input.to_i
		else
			puts "that was not a valid answer.\nyou must type one of the integers listed above"
		end
	end 
	return input
end
#--------------------------------
def options_response(options, input)
	input -= 1 
	puts options[input]
end 
#--------------------------------
def display_inventory
	b = 1
	$player_inventory.each do |choice|
		puts "    #{b}. " + choice
		b += 1
	end
end
#--------------------------------
def combat_single_enemy(enemy_name, enemy_hp, enemy_attack)
	run = 0
	puts "prepare to fight #{enemy_name}\n you have a #{$player_weapon}"
	combat_attack = $player_attack - 5
	enemy_combat_attack = enemy_attack - 10
	if enemy_combat_attack < 0
		enemy_combat_attack = 0
	end
	input = user_choice($combat_options)
	options_response($combat_responses, input)
	if input == 2 
	run = 0
	end
	while enemy_hp > 0 && run == 0
	if input == 1
		puts "you hit the #{enemy_name}"
		enemy_hp -= rand(combat_attack..$player_attack)
		puts "the #{enemy_name} has #{enemy_hp} health"
		if enemy_hp > 0
			puts "the #{enemy_name} hits back"
			$player_health -= rand(enemy_combat_attack..enemy_attack)
			if $player_health > 0
				puts "you have #{$player_health} health"
				input = user_choice($combat_options)
				options_response($combat_responses, input)
			else 
				puts "You Die"
				$playing = false
			end

		else 
			puts "the #{enemy_name} dies"
			puts "do you want to heal yourself?"
			options = ["heal yourself"]
			responses = ["you heal yourself"]
			input = user_choice(options)
			options_response(responses, input)
			if input == 1 
				$player_health = $player_max_health
			end
		end
	elsif input == 2 
		run = 1 
	end

	end
	if run == 1 
		return true
	else 
		return false
	end
	#sleep 3 
end
#--------------------------------
def add_weapon(weapon_name, weapon_id, weapon_attack)
	if weapon_id > $player_weaponID
		$player_weapon = weapon_name
		$player_attack = weapon_attack
		$player_inventory[$player_inventory.length] = weapon_name 
	else 
		puts "your previous weapon is better"
	end
end
#--------------------------------
def large_eldrazi_combat(name, enemy_attack_name, enemy_attack_damage, enemy_hp)
	dodge_options = ["dodge to the side", "dodge forward", "dodge back"]
	dodge_responses = ["you jump to the side", "you jump forward", "you jump back"]
	run = 0
	puts "prepare to fight the #{name}!"
	input = user_choice($combat_options)
	options_response($combat_responses, input)
	combat_attack = $player_attack - 5
	if input == 2 
		run = 1 
	end
	while enemy_hp > 0 && run == 0 && $player_health > 0
		if input == 1
			atk_number = rand(0..3)
			if atk_number == 0
				puts "the #{name} tries to #{enemy_attack_name[0]}"
				dodge_action = user_choice(dodge_options)
				options_response(dodge_responses, dodge_action)
				if dodge_action == 2 
					puts "you dodge the attempt to #{enemy_attack_name[0]}"
				else 
					puts "you get hit"
					$player_health -= rand(enemy_attack_damage[0] - 20..enemy_attack_damage[0])
					if $player_health > 0
						puts "you have #{$player_health} health"
					else 
						puts "You Die"
						$playing = false
					end
				end
			elsif atk_number == 1 
				puts "the #{name} tries to #{enemy_attack_name[1]}"
				dodge_action = user_choice(dodge_options)
				options_response(dodge_responses, dodge_action)
				if dodge_action == 1 
					puts "you don't get hit by the #{name} attempting to #{enemy_attack_name[1]}"
				else 
					puts "you get hit"
					$player_health -= rand(enemy_attack_damage[1] - 10..enemy_attack_damage[1])
					if $player_health > 0
						puts "you have #{$player_health} health"
					else 
						puts "You Die"
						$playing = false
					end
				end
			elsif atk_number == 2 
				puts "the #{name} tries to #{enemy_attack_name[2]}"
				dodge_action = user_choice(dodge_options)
				options_response(dodge_responses, dodge_action)
				if dodge_action == 3
					puts "you seccessfully avoid the #{name} trying to #{enemy_attack_name[2]}"
				else 
					puts "you get hit"
					$player_health -= rand(enemy_attack_damage[2] - 10..enemy_attack_damage[2])
					if $player_health > 0
						puts "you have #{$player_health} health"
					else 
						puts "You Die"
						$playing = false
					end
				end
			elsif atk_number == 3 
				puts "the #{name} tries to #{enemy_attack_name[3]}"
				dodge_action = user_choice(dodge_options)
				options_response(dodge_responses, dodge_action)
				if dodge_action == 3
					puts "you get out of the way just in time when the #{name} tries to #{enemy_attack_name[3]}"
				else 
					puts "you get hit"
					$player_health -= rand(enemy_attack_damage[3] - 10..enemy_attack_damage[3])
					if $player_health > 0
						puts "you have #{$player_health} health"
					else 
						puts "You Die"
						$playing = false
					end
				end
			end
			if $player_health > 0
				input = user_choice($combat_options)
				options_response($combat_responses, input)
				if input == 2 
					run = 1
				elsif input == 1 
					enemy_hp -= rand(combat_attack..$player_attack)
					puts "the #{name} has #{enemy_hp} health"
					if enemy_hp <= 0 
						puts "the #{name} dies"
						puts "do you want to heal yourself?"
						options = ["heal yourself"]
						responses = ["you heal yourself"]
						input = user_choice(options)
						options_response(responses, input)
						if input == 1 
							$player_health = $player_max_health
						end
					end
				end
			end
		end
	end
	if run == 1
		return true
	end
	return false
end 
#--------------------------------
def multi_enemy_combat(enemy_names, damages, enemy_hps) 
	b = 0 
	total_hp = 0
	combat_attack = $player_attack - 5
	enemy_hps.each do |each| 
		total_hp += each
	end
	run = 0
	options = ["run", "hit them all"]
	responses = ["you flee like a weenie", "you hit them all"]
	enemy_names.each do |name|
		options[options.length] = "hit the #{name}"
	end
	enemy_names.each do |name|
		responses[responses.length] = "you hit the #{name}"
	end
	input = user_choice(options)
	options_response(responses, input)
	if input == 1 
		run = 1 
	end
	while run == 0 && $player_health > 0 && total_hp > 0
		if input == 2 #-----
			b = 0
			for single_enemy in enemy_hps
				single_enemy = (rand(combat_attack..$player_attack)/enemy_hps.length)
				#puts single_enemy
				enemy_hps[b] -= single_enemy
				#puts enemy_hps[b]
				b += 1
			end
			total_hp = 0
			enemy_hps.each do |each| 
				total_hp += each
			end
		elsif input == 1 #-----
			run = 1 
		elsif input != 1 && input != 2 && input <= enemy_names.length+2#-----
			enemy_hps[input - 3] -= rand(combat_attack..$player_attack)
			#puts "---#{enemy_hps[input - 3]}---="
			if enemy_hps[input - 3] > 0
				#puts enemy_names[input - 3] + "===="
				puts "the #{enemy_names[input - 3]} has #{enemy_hps[input - 3]} health"
			else 
				puts "the #{enemy_names[input - 3]} dies"
				enemy_names[input - 3] = enemy_names[input - 3] + " - dead - "
				puts enemy_hps[input - 3]
				#puts "===---==="
				enemy_hps[input - 3] = 0
				total_hp = 0
				enemy_hps.each do |each| 
					total_hp += each
				end
			end
		end
		a = 0
		attacks = []
		enemy_hps.each do |hps|
		#puts "-----#{hps}-----"
			if hps > 0
				attacks[a] = "the #{enemy_names[a]} hits you"
				puts attacks[a]
				$player_health -= rand(damages[a]-3..damages[a]+2)
			end
			a+=1
		end
		puts "you have #{$player_health} health"
		if $player_health > 0 && total_hp > 0
		input = user_choice(options)
		options_response(responses, input)
		end
	end
	if total_hp <= 0 
		puts "do you want to heal yourself?"
		options = ["heal yourself"]
		responses = ["you heal yourself"]
		input = user_choice(options)
		options_response(responses, input)
		if input == 1 
			$player_health = $player_max_health
		end
	end
	if run == 1 
		return true
	else 
		return false
	end
end
#--------------------------------
def Kozilek(attack_types, attack_responses, attack_damage, health)
	dodge_options = ["dodge to the side", "dodge forward", "dodge back"]
	dodge_responses = ["you jump to the side", "you jump forward", "you jump back"]
	options = ["hit his right leg", "hit his left leg", "jump off the edge", "climb Kozilek"]
	responses = ["you hit his right leg", "you hit his left leg", "you jump off the edge. \nYou Die", "Kozilek grabs you and throws you off him"]
	puts "Time to Capture the Titan, Kozilek"
	input = user_choice(options)
	options_response(responses, input)
	attack_amount = 5
	combat_attack = $player_attack - 5
	run = 0
	while run == 0 && $player_health > 0 && health > 0
		if input == 1 || input == 2 || input == 4 
			atk_number = rand(1..attack_amount)
			if input == 1 || input == 2
				health -= rand(combat_attack..$player_attack)
				if health < 10 
					health = 10 
				end
				puts "Kozilek has #{health} health"
			elsif input == 4
				if health > 50 
					$player_health -= rand(2..7)
					puts "you have #{$player_health} health"
				elsif health <= 50 
					if $hedron_knife == 1
					finisher_options =["Stab Him!", "Jump Off!"]
					finisher_responses = ["You shank him in the head!\nHe turns to stone but as his last action, he throws you at the ground.\n he falls down and blocks the way back", "you jump off but Kozilek hits you off the edge.\nYou Die."]
					finisher = user_choice(finisher_options)
					options_response(finisher_responses, finisher)
					if finisher == 1 
						$player_health -= rand(5..15)
						puts "you have #{$player_health} health"
						health = 0
						$hedron_knife = 0 
					elsif finisher == 2
						$player_health = 0
						$playing = false
					end
				end
			end
		elsif input == 3
			$player_health = 0
			puts"asdhflkasjdf"
			$playing = false
		end 
	end
	if $player_health > 0 && health > 0
	if health <= 50 && $hedron_knife == 1
		responses[3] = "you climb him as he staggers around.\nYou reach his head."
		attack_amount = 6
	end
	if atk_number == 1 
		puts "Kozilek tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 2
			puts "you don't get mind warped"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 2
		puts "Kozilek tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 
			puts "you don't get squished"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
		elsif atk_number == 3
		puts "Kozilek tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 
			puts "you don't get pummbled"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 4
		puts "Kozilek tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 3 
			puts "you don't get smashed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 5
		puts "Kozilek tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 
			puts "you don't get grabbed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 6
		puts "Kozilek tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 2
			puts "you don't fall down"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	end
	input = user_choice(options)
	options_response(responses, input)
	end
	end
	puts "do you want to heal yourself?"
	options = ["heal yourself"]
	responses = ["you heal yourself"]
	input = user_choice(options)
	options_response(responses, input)
	if input == 1 
		$player_health = $player_max_health
	end
	return false
end
#--------------------------------
def Ulamog(attack_types, attack_responses, attack_damage, health)
	dodge_options = ["dodge to the side", "dodge forward", "dodge back"]
	dodge_responses = ["you jump to the side", "you jump forward", "you jump back"]
	options = ["hit him", "climb Ulamog"]
	responses = ["you hit him", "Ulamog grabs you and throws you off him"]
	puts "Time to Capture the Titan, Ulamog"
	input = user_choice(options)
	options_response(responses, input)
	attack_amount = 5
	run = 0
	combat_attack = $player_attack - 5
	while run == 0 && $player_health > 0 && health > 0
		if input == 1 || input == 2
			atk_number = rand(1..attack_amount)
			if input == 1
				health -= rand(combat_attack..$player_attack)
				if health < 10 
				health = 10 
				end
				puts "Ulamog has #{health} health"
			elsif input == 2
				if health > 50 
					$player_health -= rand(2..7)
					puts "you have #{$player_health} health"
				elsif health <= 50 
					if $hedron_knife == 1
					finisher_options =["Stab Him!", "Jump Off!"]
					finisher_responses = ["You shank him in the Face!\nHe turns to stone but as his last action, he throws you at the wall.", "you jump off but Ulamog hits you off the edge.\nYou Die."]
					finisher = user_choice(finisher_options)
					options_response(finisher_responses, finisher)
					if finisher == 1 
						$player_health -= rand(5..15)
						puts "you have #{$player_health} health"
						$hedron_knife = 0 
						health = 0
					elsif finisher == 2
						$player_health = 0
						$playing = false
					end
					end
				end
			end 
		end
	if $player_health > 0 && health > 0
	if health <= 50 && $hedron_knife == 1
		responses[1] = "you climb him as he staggers around.\nYou reach his head."
		attack_amount = 6
	end
	if atk_number == 1 
		puts "Ulamog tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 2
			puts "you don't get disintigrated"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 2
		puts "Ulamog tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 
			puts "you don't get squished"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
		elsif atk_number == 3
		puts "Ulamog tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 
			puts "you don't get pummbled"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 4
		puts "Ulamog #{attack_types[atk_number - 1]}"
		names = ["eldrazi spawn 1", "eldrazi spawn 2", "eldrazi spawn 3"]
		hps = [10, 10, 10]
		damages = [5, 5, 5]
		run = false
		while run == false
		run = multi_enemy_combat(names, damages, hps)
		if run 
			puts "you can't run from these spawn"
			run = false
		else 
			run = 0
		end
		end
		run = 0 
		
	elsif atk_number == 5
		puts "Ulamog tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 
			puts "you don't get grabbed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 6
		puts "Ulamog tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 2
			puts "you don't get disintigrated"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	end
	input = user_choice(options)
	options_response(responses, input)
	end
	end
	puts "do you want to heal yourself?"
	options = ["heal yourself"]
	responses = ["you heal yourself"]
	input = user_choice(options)
	options_response(responses, input)
	if input == 1 
		$player_health = $player_max_health
	end
	return false
end
#--------------------------------
def Emrakrul(attack_types, attack_responses, attack_damage, health)
	hand_attack_types = ["annihilate you", "jump on top of you", "smack you off the edge", "squish you with both hands"]
	hand_attack_damages = [60, 40, 2000, 30]	
	dodge_options = ["dodge to the left", "dodge forward", "dodge to the right", "dodge backwards"]
	dodge_responses = ["you jump to the side", "you jump forward", "you jump back"]
	options = ["hit her", "climb Emrakrul", "jump off the edge"]
	responses = ["you hit her", "Emrakrul grabs you and throws you off her"]
	puts "Time to Capture the Titan, Emrakrul"
	input = user_choice(options)
	options_response(responses, input)
	attack_amount = 9
	regen = 4 
	run = 0
	combat_attack = $player_attack - 5
	while run == 0 && $player_health > 0 && health > 0
		if input == 1 || input == 2
			atk_number = rand(1..attack_amount)
			while atk_number == 8 && regen == 0 
				atk_number = rand(1..attack_amount)
			end
			if input == 1
				health -= rand(combat_attack..$player_attack)
				if health < 10 
				health = 10
				end
				puts "Emrakrul has #{health} health"
			elsif input == 2
				if health > 50 
					$player_health -= rand(5..15)
					puts "you have #{$player_health} health"
				elsif health <= 50 
					if $hedron_knife == 1
					finisher_options =["Stab Her!", "Jump Off!"]
					finisher_responses = ["You shank Her in the head!\nShe turns to stone but as her last action, she throws you at the ground.\n she falls down and crashes into the ground", "you jump off but Emrakrul hits you off the edge.\nYou Die."]
					finisher = user_choice(finisher_options)
					options_response(finisher_responses, finisher)
					if finisher == 1 
						$player_health -= rand(5..15)
						puts "you have #{$player_health} health"
						health = 0
						$hedron_knife = 0 
					elsif finisher == 2
						$player_health = 0
						$playing = false
					end
					end
				end
			end
		elsif input == 3
			$player_health = 0
			#puts"asdhflkasjdf"
			$playing = false
		end 
	if $player_health > 0 && health > 0 
	if health <= 50 && $hedron_knife == 1 
		responses[1] = "you climb her as she floats limply through the air.\nYou reach her head."
		attack_amount = 6
	end
	if atk_number == 1 
		puts "Emrakrul tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 2
			puts "you don't get disintigrated"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 2
		puts "Emrakrul tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 3 || dodge == 4 
			puts "you don't get smashed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
		elsif atk_number == 3
		puts "Emrakrul tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1 || dodge == 4 
			puts "you don't get smashed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 4
		puts "Emrakrul tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 4
			puts "you don't get smashed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 5
		puts "Emrakrul #{attack_types[atk_number - 1]}"
		names = ["eldrazi spawn 1", "eldrazi spawn 2", "eldrazi spawn 3"]
		hps = [10, 10, 10]
		damages = [5, 5, 5]
		run = false
		while run == false
		run = multi_enemy_combat(names, damages, hps)
		if run 
			puts "you can't run from these spawn"
			run = false
		else 
			run = 0
		end
		end
		run = 0
	elsif atk_number == 6
		puts "Emrakrul tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 3
			puts "you don't get crushed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 7
		puts "Emrakrul tries to #{attack_types[atk_number - 1]}"
		dodge = user_choice(dodge_options)
		options_response(dodge_responses, dodge)
		if dodge == 1
			puts "you don't get crushed"
		else 
			puts attack_responses[atk_number - 1]
			$player_health -= rand(attack_damage[atk_number -1]-10..attack_damage[atk_number -1])
			puts "you have #{$player_health} health"
		end
	elsif atk_number == 8
		puts "Emrakrul #{attack_types[atk_number - 1]}"
		health += rand(50..200)
		puts "Emrakrul now has #{health} health"
	elsif atk_number == 9
		puts "Emrakrul #{attack_types[atk_number - 1]}"
		run = false
		while run == false
		run = large_eldrazi_combat("Hand of Emrakrul", hand_attack_types, hand_attack_damages, 100)
		if run 
			puts "you can't run from these spawn"
			run = false
		else 
			run = 0
		end
		end
		run = 0
	end
	if $player_health > 0
	input = user_choice(options)
	options_response(responses, input)
	end
	end
	end
if $player_health > 0
	puts "do you want to heal yourself?"
	options = ["heal yourself"]
	responses = ["you heal yourself"]
	input = user_choice(options)
	options_response(responses, input)
	if input == 1 
		$player_health = $player_max_health
	end
	return false
	end
	if $player_health <= 0 
	return true 
	end 
end
#--------------------------------
def Ugin(set1_dialouge, set1_responses, set2_1_dialouge, set2_1_responses, set2_2_dialouge, set2_2_responses, set2_3_dialouge, set2_3_responses)
puts "you are now talking to Ugin"
puts "'#{set1_dialouge}'"
input = user_choice(set1_responses)
if input == 1 
	puts "'#{set2_1_dialouge}'"
	input2 = user_choice(set2_1_responses)
	if input2 == 1 
		puts "you climb onto Ugin, he takes off and soars through the skies. \n
You begin to near a section of floating rocks and see Emrakrul behind them.
you near the rocks and Ugin lands on a particularly large one. 
He says, 'Ok this is the final area of the test. Good luck, you'll need it.'\nhe hands you a hedron knife"
	$hedron_knife = 1 
	elsif input2 == 2 
		puts "you jump off the cliff.\nYou Die"
		$playing = false
	end
elsif input == 2
	puts "'#{set2_2_dialouge}'"
	input2 = user_choice(set2_2_responses)
	if input2 == 1 
		puts "you climb onto Ugin, he takes off and soars through the skies. \n
You begin to near a section of floating rocks and see Emrakrul behind them.
you near the rocks and Ugin lands on a particularly large one. 
He says, 'Ok this is the final area of the test. Good luck, you'll need it.'.'\nhe hands you a hedron knife"
	$hedron_knife = 1 
	elsif input2 == 2
		puts "you jump off the cliff.\nYou Die"
		$playing = false 
	end 
elsif input == 3 
	puts "'#{set2_3_dialouge}"
	input2 = user_choice(set2_3_responses)
	if input2 == 1 
		puts "you stab yourself in the chest.\nYou Die"
		$playing = false
	else 
		puts "you jump off the cliff.\nYou Die"
		$playing = false 
	end
else 
	puts "Ugin Eats You."
end
end

# CODE ---------------------------------------------------------------------------------------------------------

#variables-----------------------

#check point exempt variables
re_try = true
check_point = 1
checkpoint_hp = 30
checkpoint_hp_max = 50
checkpoint_inventory = []
checkpoint_attack = 1
checkpoint_weapon = "fists"
check_point_weapon_id = 0
check_point_kozilek = false
check_point_Kmomento = false
check_point_Umomento = false 

#----------------------------

while re_try
kozilek = check_point_kozilek
ulamog = true
emrakrul = true
room10_artisan_live = true
room17_channeler = true 
room28_pathrazer = true
room41_hand = true 
room29_fight = true 
room26_fight = true
$kozilek_momento = check_point_Kmomento
$ulamog_momento = check_point_Umomento
$playing = true
room = check_point
run = false
room1_key = 0
room3_gear = 0
$player_health = checkpoint_hp
$player_max_health = checkpoint_hp_max
$player_inventory = checkpoint_inventory
$player_attack = checkpoint_attack
$player_weapon = checkpoint_weapon
$player_weaponID = check_point_weapon_id
$combat_options = ["Hit it", "Run"]
$combat_responses = ["you hit it", "you flee for you life"]
$hedron_knife = 1
room10_artisan_attack_type = ["annihilate you", "smack you from the top", "swipe at you from the side", "stomp on you"]
room10_artisan_attack_damage = [50, 27, 15, 23]
room28_pathrazer_attack_types = ["annihilate you", "smash you with two arms", "pummble you with all 4 arms", "stomp on you"]
room28_pathrazer_attack_damages = [50, 36, 40, 28]
room41_hand_attack_types = ["annihilate you", "jump on top of you", "smack you off the edge", "squish you with both hands"]
room41_hand_attack_damages = [60, 40, 2000, 30]
kozilek_attack_types = ["Mind Warp you", "Smash you from the top", "Hit you with his 50 tentacles", "smash you with both hands", "grab you", "warp the ground around you"]
kozilek_attack_responses = ["You can't seem to tell whats going on.\nAn arm smacks you off to the side.", "you get squished", "GET PUMMBLED SCRUB!", "you get clapped", "Kozilek grabs and throws you.", "you fall down.\nThe earth itself is bending to the Titan's will.\n he moves forward and merely crushes you as you get up"]
kozilek_attack_damages = [30, 25, 35, 40, 15, 35]
ulamog_attack_types = ["Disingrate you", "squish you", "hit you with his 200 tentacles", "sends 3 spawn at you", "grab you", "disingrate the room around you"]
ulamog_attack_responses = ["you feel tingly and parts of your skin blows away", "you get squished", "GET PUMMBLED SCRUB!", "you kill the spawn", "he grabs you and throws you", "the world itself is getting destroyed to feed the titan."]
ulamog_attack_damages = [50, 25, 35, 0, 20, 40]
emrakrul_attack_types =["Disintigrate you", "smash you from the left with one tentacle", "smash you from the right with one tentacle", "squish you with two tentacles", "summons 3 eldrazi spawn", "swing 4 tentacles at you from the left",
"swing 4 tentacles at you from the right", "grabs and consumes afloating rock for energy", "summons a Hand of Emrakrul" ]
emrakrul_attack_responses = ["parts of your skin dissolves into dust", "his tentacle smashes you into the rock", "his tentacle smashes you into the rock", "his tentacles smashes you into the rock", "", "you get severly pummbled into the rock", 
"you get severly pummbled into the rock", "", ""]
emrakrul_attack_damages = [50, 45, 45, 50, 0, 60, 60, 0, 0]
take = 0
kozilek_momento_placed = false
ulamog_momento_placed = false

# ROOM OPTIONS AND RESPONSES ----------------------------------------------------------------------------------

backstory_responses = ["
A long time ago, three titans roamed between worlds. Each world is known as a separate plane of existance.
These titans would consume the world for themselves then move on to continue feeding.
Then three beings, planeswalkers as they were called, decided to stop the Three. Ugin, an elder dragon planeswalker,
Sorin Markov, an ancient vampire, and Nahiri, a stone-shaping white humaniod called a Kor. These three Titans, 
they are known as Eldrazi. Emrakrul, a gigantic floating island with bisecting arms and tentacles. Ulamog, a semi-
humanoid being with tentacles for legs and arms bisecting at the elbows. and Kozilek, a tower covered in eyes,
two massive arms, and on his head however no eyes are prevelant.
Now, these titans are many many stories tall. Big enough to obliterate most of our school in one tentacle swipe.
(pictures:  http://static.comicvine.com/uploads/original/11116/111169812/3891882-1382931108889.png

The three planeswalkers had tried to kill these Titans, but had failed. In a desparate course of action, they 
imprisoned them on a wondorus plane known as Zendikar, hopefully for eternity the Eldrazi would stay imprisoned. 
The prison was constructed of stone diamonds called hedrons. the Hedrons were filled with magic to freeze the 
eldrazi inplace. But, No prison lasts forever. The Eldrazi slubered for centuries, waiting for a chance to free 
themselves! 

Several centuries passed, the bars on the prison were tested, the Titans came close to breaking free. They loosed 
upon the plane many lesser eldrazis, but however, the three Planeswalkers returned and strengthened the bars holding
the titans. The Titans returned to dormancy, but the lesser eldrazi ravaged the plane. But as fortune has it, Zendikar 
it's self developed a natural immune system and killed off the lesser eldrazis. This immunesystem is known as The Roil.

The Roil is both a fantastic thing and a terror to the people. Natural elemental behemoths roamed the land. traps laid
out through the land were created. continents moved on their own free will. Rocks floated. Hurricanes and Tornadoes 
were an every day thing. The people on Zendikar veiwed this roil as an every day thing, but the planeswalkers who came 
to this plane saw the roil as a dangerous thing, an untamed world, a place filled with monsters made from the earth.

Another mellinia passed, the Eldrazi slumbered. Then through a long careful plot by a sinister elder dragon the Eldrazi
were released. With them thousands of eldrazi spawn appeared. The Roil sprang back into action. The plane was getting
destroyed. But our three planeswalkers returned to trap them again. But for some reason it wasn't working the way it
should. That is where you come in, at the high point in the fight for Zendikar's survival.

You wake up on the edge of a floating Island. There is a door and a smallish space to move around on.
", "Ok, moving on."]
backstory_options = ["yes", "no"]
#room 1
room1_options = ["go through the door", "look around", "jump off the edge", ]
room1_responses = ["the door is locked", "you see a wondorus landscape filled with floating islands and 
birds of all different varietys. you also find and take a key.", "why did you jump off the edge. You Die.
Luke, Stop it."]
#room 2
room2_options = ["go through the door on the left", "go thorugh the door on the right", "read the board in front of you", "go back", "look around"]
room2_responses = ["you go through the door on the left,\nthere is a man leaning against the wall", "you enter a room with glowing hedrons on the wall. Ulamog turns to face you.
Your hands begin to tingle. you look at them, they are dissolving away. 
you slowly turn to dust and float away in the wind
You Die", "you read the board:
This game is a game about reimprisoning the 3 eldrazi titans. 
it was created and edited by Ethan Hunter 
tested by: \nGarrett Kawaguchi\nTyler Cohade\nLuke Duchars\nCooper Hammond\nRachel Ayers", "you go back to the cliff room", "you see a hall with 2 doors and a billboard"]
#room 3
room3_options = ["talk to the guy", "go through the door in the front", "go back", "check inventory"]
room3_responses = ["you go ande talk to the guy\n'hello there, \nyou seem to be heading to the place we were
well you seem to be in need of gear. \nhere, take my buddies stuff he won't be needing it since an eldrazi shanked him.
also you should know you can't kill a titan without a hedron knife.'\n he hands you some gear",
"you go through the door\n you enter a long curving tunnel.", "you go back", "you check you inventory"]
#room 4
room4_options = ["go forward", "go back", "look around"]
room4_responses = ["you go forward, you see the tunnel split.", "you go back to the room with the guy", "you see a tunnel. it is a very tunnely tunnel"]
#room 5
room5_options = ["go left", "go right", "go back"]
room5_responses = ["you go left, the tunnel splits again", "you go right, the tunnelk splits again. there is a hedron to your left.", "you go back"]
#room 6
room6_options = ["go left", "go right", "look around", "go back"]
room6_responses = ["you go left.\nthe tunnel splits into three separate tunnels","you go down the tunnel to the right.\nyou enter a open space in the tunnels.\nA Kozilek's channeler occupies the area.",
"you see the hedron to the left raise up and begin glowing around the middle.\nit then falls back to the ground.\nthe tunnel left spilts again, and the tunnel right has marks scoured into it.", "you go back to the first fork in the tunnel"]
#room 7
room7_options = ["go left", "go right", "look around", "go back"]
room7_responses = ["you go left, you see a crack in the wall, and a eldrazi spawn.", "you go right, the tunnel widens and connects to the left back there", "the tunnel left curves, and the tunnel right widens", "you go back"]
#room 8
room8_options = ["go forward", "go back", "look around"]
room8_responses = ["you go forward into a larger part of the tunnels that connected back to the previous split.", "you go back to the fork", "you see a crack in the wall, ther is nothing in it.\nthe tunnel widens up ahead."]
#room 9
room9_options = ["go forward", "look around", "go back left", "go back right"]
room9_responses = ["you go forward, you enter a large carvern. \nAn Artisan of Kozilek occupies the area.", "you see a corpse. the corpse looks recently killed.
also you see that the the tunnel turns up ahead", "you go back left", "you go back right", "you find a longsword on the corpse"]
#room 10 
room10_options = ["go back out of the cave", "inspect the dead artisan", "move farther down the cave", "look around"]
room10_responses = ["you go back", "the dead artisan is dead. also it is dead", "you go farther down the cave. there is a corpse", "on the other side of the cave you see a dead guy"]
#room 11 
room11_options = ["go back", "inspect the corpse", "look around"]
room11_responses = ["you go back to the first part of the cave", "you find and take a sword with hedrons imdedded in it, and a iron chestplate", "you see a cave with a corpse and a the dead Artisan of Kozilek"]
#room 12 
room12_options = ["go left", "go straight", "go right", "look around", "go back"]
room12_responses = ["you go left", "you go straight", "you go right", "you see the three tunnels converge ahead", "you go back"]
#room 13 & 14
room13_options = ["go forward", "go back", "look around"]
room13_responses = ["you go forward to were the tunnels reconnect", "you go back to were the tunnels split", "you see a hole in the wall and that the three split tunnels combine up ahead"]
#room 14 
room15_options = ["go forward", "go back", "look around"]
room15_responses = ["you go forward to were the tunnels reconnect", "you go back to were the tunnels split", "you see that the three split tunnels combine up ahead"]
#room 16
room16_options = ["go back left", "go back right", "go back straight", "look around", "go forward"]
room16_responses = ["you go back left", "you go back right", "you go back through the middle tunnel", "you see the three tunnels behind you\nand you see a hole in the wall where the edrazi spawn jumped out of
you also see the tunnel ahead is long and curved", "you go forward, the tunnel splits"]
#room 17 
room17_options = ["climb down off the ledge", "go back through the tunnel", "look around"]
room17_responses = ["you climb down the ledge, the tunnel splits again, \none tunnel goes down right.\nthe other is flat and goes left", "you go back to the area with the hedron", "you see a dead Kozilek's Channeler, \nand you see the tunnel go over a ledge then continue"]
#room 18 
room18_options = ["go down the tunnel going down", "go along the tunnel that is flat", "go back up the ledge"]
room18_responses = ["you go down. \nthe tunnel stops but there is a dead guy with a hedron knife", "you go along the tunnel", "you hop up the ledge"]
#room 19 
room19_options = ["go back", "take the knife"]
room19_responses = ["you go back", "you take the knife"]
#room 20 
room20_options = ["go into the upward tunnel", "go along the flat tunnel", "go along the skinny tunnel", "look around"]
room20_responses = ["yo go up, the tunnel evens out into a gigantic cavern.\nThe Titan Kozilek occupies the area", "you go down the skinny tunnel, it then splits into 3 separate tunnels", "the note says, 'you can't kill the titan without a hedron knife'"]
#room 21 
room21_options = ["Attack!", "Flee!"]
room21_responses = ["You Charge the Eldrazi Titan!!!", "You turn to flee, but Kozilek smashes the wall!\nThe tunnel you are trying to flee into, collapses.\nYou turn around, Kozilek is there...\tyou begin to dissolve into the wind. \nYou Die"]
#room 22 
room22_options = ["look around", "jump off the edge"]
room22_responses = ["you see a small tunnel leading out of the cavern.\nKozilek blocks the way you came in.", "why did you jump off the edge. You Die.", "you go through the small tunnel, it turns into a actual room with a chest.\nthere is a door in front"]
#room 23 
room23_options = ["go through the door in front", "look around", "check you inventory", "open the chest."]
room23_responses = ["you go through the door, there is a hall way with a door on the left at eh end.", "there is nothing you don't already see.", "you check you inventory", "you find a weirdly shaped stone. \nIt seems to take on the appearance of Kozilek"]
#room 24
room24_options = ["go through the door on the left", "go back", "look around"]
room24_responses = ["you go through the door.", "you go back to the room with the chest", "there is bricks on the wall. there is a door up left."]
#room 25
room25_options = ["go through the door in front", "go back", "look forward"]
room25_responses = ["you go forward\nyou enter a big room with furrows along the wall\nlots of eldrazi occupy the area. some of them come after you", "you go back to the hallway.", "Wow a room with two doors and a hole in the wall."]
#room 26 
room26_options = ["go forward", "go back", "inspect the corpses"]
room26_responses = ["you go forward. you enter a small room", "you go back", "the corpses are dead."]
#room 27 
room27_options = ["go forward", "go back", "look around"]
room27_responses = ["you go forward\nAn Pathrazer of Ulamog occupies the area", "you go back", "you look around. you see a small room with two doors"]
#room 28 
room28_options = ["go through the door you came out of", "go through the other door", "inspect the dead Pathrazer"]
room28_responses = ["you go through the door. there is a long hall way", "you go through the door\nthere are two murk striders there", "it is dead"]
#room 29
room29_options = ["go back", "go down the hall", "look around"]
room29_responses = ["you go back to the room with the Pathrazer", "you go down the hall, there is a door at the other end", "you see two dead Murk Striders in a long hall"]
#room 30 
room30_options = ["go through the door in front", "go back down the hall"]
room30_responses = ["you go through the door, ther are a set of stairs going up to the left.", "you go back"]
#room 31
room31_options = ["go up the stairs", "go back"]
room31_responses = ["up we go", "you go back"]
#room 32 
room32_options = ["Jump down to fight Ulamog", "look around", "go back", "take the hedron knife from the dead guy"]
room32_responses = ["Let's kill the Titan!", "you see a old mummified corpses, it has some with powder spread on top of it.\n Ulamog resides below you and giant hedrons are imbedded on the wall", "you go back", "you take the hedron knife"]
#room 33 
room33_options = ["try to climb back up to the ledge you jumped off", "go to the door on the ooposite side of the room from the ledge", "go to the door closer to the ledge", "inspect ulamog"]
room33_responses = ["you can't seem to get back up", "you go through the door, there is a circular room with a chest", "you go through the door, it is the room with the billboard."]
#room 34
room34_options = ["go back", "open the chest", "check your inventory"]
room34_responses = ["you go back", "you open the chest. \nyou find a stange carving it looks vuagely like Ulamog", "you check you inventory"]
#room 35 
room35_options = ["go through the door right, the one you came from", "go through the door left", "go through the door middle", "read the billboard"]
room35_responses = ["you go back", "the door is locked. you hear someone yell\n'Go Away!", "you go back to the first cliff area\nthere is a dragon hovering just off the cliff", "you read the board:
This game is a game about reimprisoning the 3 eldrazi titans. 
it was created and edited by Ethan Hunter 
tested by: \nGarrett Kawaguchi\nTyler Cohade\nLuke Duchars\nCooper Hammond\nRachel Ayers"]
#room 36 
room36_options = ["jump off the edge", "go back", "talk to the dragon"]
room36_responses =["you jump  off the edge,\nYouDie","you go back", "you talk to Ugin"]
#Ugin Dialouge 
set1_dialouge = "well, you did it. you vanquished two eldrazi titans. \nI didn't think you would succeed."
set1_responses = ["'Yes and it was easy'", "'You! you set me up for this!'", "'HURDY DURDY DURDY DURDY DURDY'", "shank Ugin"]
set2_1_dialouge = "you seem smug.\nNow, I'm going to take you to vanquished the third titan"
set2_1_responses = ["'Ok take me there'", "jump off the cliff."]
set2_2_dialouge = "Yes I did, and you did a lot better than expected.\nNow, do you want to vanquished the third titan"
set2_2_responses = ["'Yes. lets get him!'", "jump off the cliff"]
set2_3_dialouge = "what are you doing? Goodbye.' Ugin flies off"
set2_3_responses = ["stab self", "jump off the cliff"]
#room 37 
room37_options = ["hop onto the rock path left", "hop onto the rock path right", "look over the edge"]
room37_responses = ["you hop onto the rocks", "you hop onto the rocks", "you frind and take a hedron chestplate."]
#room 38 
room38_options = ["go forward", "go back", "go right"]
room38_responses = ["you go forward onto a big section of rock", "you go back to the big chunk of rock", "you go right to a section of rock that is connected to the big section from back there"]
#room 39 
room39_options = ["go left", "go right", "go back"]
room39_responses = ["you go left to a section of rock that is connected to the big section from back there", "you go right, there is a a pedastal on the rock chunk you are on.", "you go back to the big section."]
#room 40 
room40_options = ["go back"]
room40_responses = ["you go back", "", "", "you take the legendary sword"]
#room 41 
room41_options = ["go across the edlrazi spawn infested pathway", "go back", "look around"]
room41_responses = ["you head across", "you go back", "you see Emrakrul behind the infested pathway/"]
#room 43
room43_options = ["Attack Emrakrul", "jump off the floating rocks"]
room43_responses = ["CHARGE!", "Why... ? you were so close."]

# ----------------------- ROOMS -------------------------------------------------------------------------------

#Ugin(set1_dialouge, set1_responses, set2_1_dialouge, set2_1_responses, set2_2_dialouge, set2_2_responses, set2_3_dialouge, set2_3_responses)
puts "do you wish to hear the backstory?"
input = user_choice(backstory_options)
options_response(backstory_responses, input)

while $playing
if room == 1 
input = user_choice(room1_options)
#puts input
options_response(room1_responses, input)
#puts "key"
if input == 2
room1_responses[0] = "you unlock and go through the door.\nyou enter a hall with two doors and a billboard"
$player_inventory[0] = "a strange looking key"
room1_key = 1
room1_responses[1] = "you find nothing else"
elsif room1_key == 1 && input == 1
room = 2
elsif input == 3
$playing = false
end
end
# -----------------------------------------------
if room == 2
input = user_choice(room2_options)
options_response(room2_responses, input)
if input == 1 
room = 3
elsif input == 2
$playing = false 
elsif input == 4
room = 1 
end
end
# -----------------------------------------------
if room == 3
input = user_choice(room3_options)
options_response(room3_responses, input)
if input == 1 && room3_gear == 0
room3_responses[0] = "now go kill some eldrazi!"
room3_gear = 1 
$player_inventory[$player_inventory.length] = "leather armor"
add_weapon("short sword", 1, 10)
elsif input == 2
room = 4
elsif input == 3 
room = 2
elsif input == 4
display_inventory
end
end
# -----------------------------------------------
if room == 4
input = user_choice(room4_options)
options_response(room4_responses, input)
if input == 1
room = 5
elsif input == 2 
room = 3 
end
end
#------------------------------------------------
if room == 5
input = user_choice(room5_options)
options_response(room5_responses, input)
if input == 1 
room = 7
elsif input == 2 
room = 6 
elsif input == 3 
room = 4
end
end
#------------------------------------------------
if room == 6
input = user_choice(room6_options)
options_response(room6_responses, input)
if input == 1 
room = 12
#puts "you can't go that way yet"
elsif input == 2
room = 17
#puts "you can't go that way yet"
elsif input == 4
room = 5
end
end
#------------------------------------------------
if room == 7
input = user_choice(room7_options)
options_response(room7_responses, input)
if input == 1 
room = 8
elsif input == 2 
room = 9
elsif input == 4 
room = 5 
end
end 
#------------------------------------------------
if room == 8 
puts "an eldrazi spwn jumps out of a crack in the wall"
run = combat_single_enemy("eldrazi spawn", 8, 5)
if run == true 
	room = 7
end
while run == false
input = user_choice(room8_options)
options_response(room8_responses, input)
if input == 1 
	room = 9
	run = true
elsif input == 2 
	room = 7
	run = true
end
end
end
#------------------------------------------------
if room == 9
input = user_choice(room9_options)
options_response(room9_responses, input)
if input == 1 
room = 10
elsif input == 2
if $player_weapon != "longsword"
	room9_options[4] = "inspect corpse"
end
elsif input == 3 
room = 7 
elsif input == 4 
room = 8 
elsif input == 5 
if $player_weapon != "longsword"
	add_weapon("longsword", 2, 15)
	room9_options = ["go forward", "look around", "go back left", "go back right"]
	$player_inventory[$player_inventory.length] = "hedron sword"
end
end
end
#------------------------------------------------
if room == 10 
if room10_artisan_live
	room10_artisan_live = large_eldrazi_combat("Artizan of Kozilek", room10_artisan_attack_type, room10_artisan_attack_damage, 80)
end
if room10_artisan_live == false && $player_health > 0
input = user_choice(room10_options)
options_response(room10_responses, input)
if input == 1 
room = 9
elsif input == 3 
room = 11 
end
else room = 9
end
end
#------------------------------------------------
if room == 11 
input = user_choice(room11_options)
options_response(room11_responses, input)
if input == 1
room = 10
elsif input == 2 && take != 1
add_weapon("hedron sword", 3, 25)
$player_health += 20
$player_max_health += 20 
take = 1
room11_responses[1] = "the corpse has nothing else"
end
end
#------------------------------------------------
if room == 12 
input = user_choice(room12_options)
options_response(room12_responses, input)
if input == 1 
room = 15 
elsif input == 2 
room = 14 
elsif input == 3 
room = 13
elsif input == 5
room == 6
end
end
#------------------------------------------------
if room == 13 || room == 14
puts "an eldrazi spawn jumps out of a hole in the wall!"
combat_single_enemy("eldrazi spawn", 8, 5)
input = user_choice(room13_options)
options_response(room13_responses, input)
if input == 1 
room = 16
elsif input == 2 
room = 12
end
end
#------------------------------------------------
if room == 15 
input = user_choice(room15_options)
options_response(room15_responses, input)
if input == 1 
room = 16
elsif input == 2 
room = 12
end
end
#------------------------------------------------
if room == 16 
puts "an eldrazi spawn runs at you from behind."
combat_single_enemy("eldrazi spawn", 8, 5)
input = user_choice(room16_options)
options_response(room16_responses, input)
if input == 1
room = 15
elsif input == 2 
room = 13
elsif input == 3 
room = 14 
elsif input == 5 
room = 20 
end
end
#------------------------------------------------
if room == 17 
if room17_channeler
room17_channeler = combat_single_enemy("Kozilek's Channeler", 30, 15)
end
if room17_channeler == false
input = user_choice(room17_options)
options_response(room17_responses, input)
if input == 1 
room = 18 
elsif input == 2 
room = 6 
end
end
end
#------------------------------------------------
if room == 18 
input = user_choice(room18_options)
options_response(room18_responses, input)
if input == 1 
room = 19 
elsif input == 2 
room = 20
elsif input === 3 
room = 17
end
end 
#------------------------------------------------
if room == 19 
input = user_choice(room19_options)
options_response(room19_responses, input)
if input == 1 
room = 18 
elsif input == 2 && $hedron_knife == 0 
$hedron_knife = 1 
room19_options = ["go back"]
room19_responses = ["you go back"]
end
end
#------------------------------------------------
if room == 20
input = user_choice(room20_options)
options_response(room20_responses, input)
if input == 1 
room = 21 
elsif input == 2 
room = 18 
elsif input == 3 
room = 16
end
end
#------------------------------------------------
if room == 21 
input = user_choice(room21_options)
options_response(room21_responses, input)
if input == 1
room = 22
elsif input == 2
$playing = false
end
end 
#------------------------------------------------
if room == 22 
if kozilek
	kozilek = Kozilek(kozilek_attack_types, kozilek_attack_responses, kozilek_attack_damages, 150)
	puts "\nCHECKPOINT SET.\n\n "
	check_point = room
	checkpoint_hp = $player_health
	checkpoint_hp_max = $player_max_health
	checkpoint_inventory = $player_inventory
	checkpoint_attack = $player_attack
	checkpoint_weapon = $player_weapon
	check_point_weapon_id = $player_weaponID
	check_point_kozilek = false
end
if kozilek == false
	input = user_choice(room22_options)
	options_response(room22_responses, input)
	if input == 1 
		room22_options[2] = "go through the small tunnel."
	elsif input == 2 
		$playing = false 
	elsif input == 3
		room = 23
	end
end
end
#------------------------------------------------
if room == 23 
input = user_choice(room23_options)
options_response(room23_responses, input)
if input ==  1 
	room = 24
elsif input == 3 
	display_inventory
elsif input == 4 && room23_options.length == 4
	$player_inventory[$player_inventory.length] = "Kozilek Momento"
	$kozilek_momento = true
	room23_options = ["go through the door in front", "look around", "check you inventory"]
end
end
#------------------------------------------------
if room == 24 
input = user_choice(room24_options)
options_response(room24_responses, input)
if input == 1 
room = 25 
elsif input == 2 
room = 23
end
end
#------------------------------------------------
if room == 25 
run = false
puts "there are 5 eldrazi spawn in the room"
enemies = ["eldrazi spawn 1", "eldrazi spawn 2", "eldrazi spawn 3", "eldrazi spawn 4", "eldrazi spawn 5"]
hps = [10, 10, 10, 10, 10]
damages = [5, 5, 5, 5, 5]
run = multi_enemy_combat(enemies, damages, hps)
if run 
room = 24
end
if run == false
	input = user_choice(room25_options)
	options_response(room25_responses, input)
	if input == 1 
		room = 26 
	elsif input == 2 
		room = 24 
	end
end
end
#------------------------------------------------
if room == 26 
run = false
if room26_fight
	count = 0
	while count < 10 && run == false
		type = rand(1..8)
		if type == 1 
			run = combat_single_enemy("Bane of Bala Ged", 50, 25)
		elsif type == 2 
			run = combat_single_enemy("Oblivion Sower", 70, 15)
		elsif type == 3 
			run = combat_single_enemy("Ulamog's Reclaimer", 40, 35)
		elsif type == 4
			names = ["eldrazi spawn 1", "eldrazi spawn 2", "eldrazi spawn 3"]
			hps = [10, 10, 10]
			damages = [5, 5, 5]
			run = multi_enemy_combat(names, damages, hps)
		elsif type == 5 
			names = ["eldrazi spawn 1", "eldrazi spawn 2"]
			hps = [10, 10]
			damages = [5, 5]
			run = multi_enemy_combat(names, damages, hps)
			if run == false 
				run = combat_single_enemy("Brood Monitor", 30, 12)
			end
		elsif type == 6 
			combat_single_enemy("Murk Strider", 35, 10)
		elsif type == 7 
			run = combat_single_enemy("Blister Pod", 10, 5)
			if run == false 
				run = combat_single_enemy("Eldrazi Spawn", 10, 5)
			end
		elsif type == 8 
			combat_single_enemy("Benthic Infiltrator", 40, 5)
		end
		count += 1
	end
	if run
		room = 25 
	end
	if run == false 
		room26_fight = false 
	end
end
input = user_choice(room26_options)
options_response(room26_responses, input)
if input == 1 
room = 27 
elsif input == 2 
room = 25
end
end
#------------------------------------------------
if room == 27 
run = combat_single_enemy("eldrazi spawn", 10, 5)
if run
room = 26 
end
if run == false 
input = user_choice(room27_options)
options_response(room27_responses, input)
if input == 1
	room = 28
elsif input == 2
	room = 27
end
end
end
#------------------------------------------------
if room == 28
if room28_pathrazer
	room28_pathrazer = large_eldrazi_combat("Pathrazer of Ulamog", room28_pathrazer_attack_types, room28_pathrazer_attack_damages, 100)
end
if room28_pathrazer ==  false
	input = user_choice(room28_options)
	options_response(room28_responses, input)
	if input == 1 
		room = 27 
	elsif input == 2 
		room = 29
	end 
else 
	room = 27
end
end
#------------------------------------------------
if room == 29 
if room29_fight
	names = ["Murk Strider 1", "Murk Strider 2"]
	hps = [35, 35 ]
	damages = [10, 10]
	room29_fight = multi_enemy_combat(names, damages, hps)
end
if room29_fight == false
	input = user_choice(room29_options)
	options_response(room29_responses, input)
	if input == 1 
	room = 28 
	elsif input == 2
	room = 30
	end
else room = 28
end
end
#------------------------------------------------
if room == 30 
input = user_choice(room30_options)
options_response(room30_responses, input)
if input == 1 
room = 31 
elsif input == 2 
room = 29
end
end
#------------------------------------------------
if room == 31 
input = user_choice(room31_options)
options_response(room31_responses, input)
if input == 1 
	room = 32
elsif input == 2 
	room = 30
end
end
#------------------------------------------------
if room == 32 
input = user_choice(room32_options)
options_response(room32_responses, input)
if input == 1 
room = 33
elsif input == 3 
room = 31 
elsif input == 4
$hedron_knife = 1 
room32_options = ["Jump down to fight Ulamog", "look around", "go back"]
end
end
#------------------------------------------------
if room == 33 
if ulamog 
ulamog = Ulamog(ulamog_attack_types, ulamog_attack_responses, ulamog_attack_damages, 200)
end
if ulamog == false 
input = user_choice(room33_options)
options_response(room33_responses, input)
if input == 2 
room = 34 
elsif input == 3 
room = 35 
end 
end
end
#------------------------------------------------
if room == 34 
input = user_choice(room34_options)
options_response(room34_responses, input)
if input  == 1 
room = 33 
elsif input == 2 && $ulamog_momento == false
$player_inventory[$player_inventory.length] = "Ulamog Momento"
room34_responses[1] = "you find nothing else"
$ulamog_momento = true 
elsif input == 3 
display_inventory
end
end
#------------------------------------------------
if room == 35 
input = user_choice(room35_options)
options_response(room35_responses, input)
if input == 1 
room = 33 
elsif input == 3
room = 36
end
end
#------------------------------------------------
if room == 36 
input = user_choice(room36_options)
options_response(room36_responses, input)
if input == 1 
$playing = false 
elsif input == 2 
room = 35
elsif input == 3 
Ugin(set1_dialouge, set1_responses, set2_1_dialouge, set2_1_responses, set2_2_dialouge, set2_2_responses, set2_3_dialouge, set2_3_responses)
if $playing 
room = 37 
end
puts "\nCHECKPOINT SET.\n\n "
check_point = room
checkpoint_hp = $player_health
checkpoint_hp_max = $player_max_health
checkpoint_inventory = $player_inventory
checkpoint_attack = $player_attack
checkpoint_weapon = $player_weapon
check_point_weapon_id = $player_weaponID
check_point_Kmomento = $kozilek_momento
check_point_Umomento = $ulamog_momento
input == user_choice(room22_options)
options_response(room22_responses, input)
end
end
#------------------------------------------------
if room == 37 
input = user_choice(room37_options)
options_response(room37_responses, input)
if input == 1 
room = 38 
elsif input == 2 
room = 39
elsif input == 3 
if $player_max_health < 60 
$player_inventory[$player_inventory.length] = "Hedron Chestplate"
$player_max_health += 30 
$player_health += 30 
room37_responses[2] = "you find nothing more"
end
end
end 
#------------------------------------------------
if room == 38 
input = user_choice(room38_options)
options_response(room38_responses, input)
if input == 1 
room = 41 
elsif input == 2 
room = 37
elsif input == 3 
room = 39 
end
end
#------------------------------------------------
if room == 39
input = user_choice(room39_options)
options_response(room39_responses, input)
if input == 1 
room = 38 
elsif input == 2 
room = 40 
elsif input == 3 
room = 37 
end
end 
#------------------------------------------------
if room == 40
if $kozilek_momento 
room40_options[1] = "place Kozilek Momento"
elsif kozilek_momento_placed 
room40_options[1] = "take Kozilek Momento"
end
if $ulamog_momento
room40_options[2] = "place Ulamog Momento"
elsif ulamog_momento_placed
room40_options[2] = "take Ulamog Momento"
end
if ulamog_momento_placed && kozilek_momento_placed
puts "a sword rises out of the pedastal"
room40_options[3] = "take Excaliber"
end
input = user_choice(room40_options)
options_response(room40_responses, input)
if input == 1 
room = 39 
elsif input == 2 && $kozilek_momento == true
kozilek_momento_placed = true 
$kozilek_momento = false
elsif input == 3 && $ulamog_momento == true
$ulamog_momento = false 
ulamog_momento_placed = true 
elsif input == 4 && ulamog_momento_placed && kozilek_momento_placed
add_weapon("Excaliber", 4, 35)
ulamog_momento_placed = false
kozilek_momento_placed = false
end
end
#------------------------------------------------
if room == 41 
if room41_hand
	room41_hand = large_eldrazi_combat("Hand of Emrakrul", room41_hand_attack_types, room41_hand_attack_damages, 100)
end
if room41_hand == false && $player_health > 0
input = user_choice(room41_options)
options_response(room41_responses, input)
if input == 1 
room = 42 
elsif input == 2 
room = 38 
end
end
end 
#------------------------------------------------
if room == 42 
if $player_weapon == "Excaliber"
puts "you mow through the eldrazi spawn, you reach the other side."
room = 43 
else
names = ["eldrazi spawn 1", "eldrazi spawn 2", "eldrazi spawn 3", "eldrazi spawn 4", "eldrazi spawn 5", "eldrazi spawn 6", "eldrazi spawn 7", "eldrazi spawn 8", "eldrazi spawn 8", "eldrazi spawn 9", "eldrazi spawn 10"]
damages = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
hps = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
multi_enemy_combat(names, damages, hps)
end
end
#------------------------------------------------
if room == 43 
input = user_choice(room43_options)
options_response(room43_responses, input)
if input == 1 && emrakrul
emrakrul = Emrakrul(emrakrul_attack_types, emrakrul_attack_responses, emrakrul_attack_damages, 400)
if $player_health <= 0
$playing = false
end
if emrakrul == false 
puts "Thank you for playing my game. \nPeople who have beat my game: \n - Garrett Kawaguchi\n -  - "
$playing = false
puts "if you restart, you will go to the last checkpoint."
end
elsif input == 2 
$playing = false
end
end
end
#game reset -------------------------------------
puts "do you wish to play again?\nenter '0' to continue"
input = gets.chomp
if input == "0"
re_try = true
else 
re_try = false 
end
end