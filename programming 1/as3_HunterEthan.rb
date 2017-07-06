#this has 27 areas 
puts "###" *30
game_end = 0
input = ""
room = 1
room1_key = 0
hp = 30
hpMax = hp
sleep = 0
room2_look = 0
room3_look = 0
room4_look = 0
room7_look = 0
room7_breakwall = 0
room8_chest = 0
room9_run = 0 
room10_look = 0
room11_look = 0
room12_look = 0
room13_look = 0
room13_breakwall = 0
room14_look = 0
room15_chest = 0
room16_chest = 0
room19_burn = 0
room22_look = 0
room22_run = 0
room22_potion_take = 0
room23_look = 0
room24_look = 0
room24_potion_take = 0
room24_run = 0 
chestplate = 0
helm = 0
leggings = 0
boots = 0
sheild = 0
player_attack = 1
knife = 0
sword = 0
greatsword = 0
torch = 0
skullOfUlamog = 0
apple = 0
player_weapon = "fists"
potion_fullHealth = 3
room8_zombieHP = 10
room9_zombieHP = 10
room11_zombie1_HP = 10
room11_zombie2_HP = 10
room22_golem_HP = 20 
room23_zombie1_HP = 10
room23_zombie2_HP = 10
room24_golem1_HP = 20
room24_golem2_HP = 20
bossHp = 200
print "welcome to my Amazing text based adventure!\n created and edited by Ethan Hunter.\n please enter the number before each option.\n"
puts"__" *20
puts"""
you wake up in a dark room, you can't see anything, all there is is a small light shining through a keyhole
you can: 
"""
while game_end == 0
#room 1 ----------------------------------
if room == 1;
 puts"    1: Try to open the door.\n    2: feel around"
if sleep == 0
 puts "    3: sleep"
end
input = gets.chomp
if input == "exit"
exit
end
input = input.to_i
if input == 1 && room1_key == 1;
  puts "You open the door and walk through."
  room = 2
   puts "you walk into a big room filled with crumbling rocks and 3 doors\ndo you:"
  #game_end = 1
elsif input == 1 && room1_key != 1;
  puts "the door is locked"
elsif input == 2 && room1_key == 0;
  puts "you find a key!"
  room1_key = 1
elsif input == 2 && room1_key == 1;
 puts "you find nothing"
elsif input == 3 && sleep == 0;
  puts "you fall asleep then awake feeling rested"  
  hp = 35 
  puts "you hp just increaed 5 points"
  sleep = 1
end
end
#room 2 ----------------------------------
if room == 2;
puts "    1: go through door A\n    2: go through door B\n    3: go through door C"
puts "    4: look around"
if room2_look == 1
  puts "    5: look in the hole"
  if knife == 0; puts "    6: take the knife"end
end
puts "    7: go back"
input = gets.chomp.to_i
if input == 1;
  puts "you go through the door"
  room = 3
  puts "you enter a small hall with a room at the end\ndo you:"
  #game_end = 1
elsif input == 2;
  puts "you go through the door"
  room = 5
elsif input == 3;
  puts "you go through the door"
  puts "you enter a very short corridor with a door at the the end."
  room = 6
elsif input == 4 && room2_look == 0;
  puts "you find a hole in the ground and a knife"
  room2_look =1
elsif input == 4 && room2_look == 1;
  puts "you find nothing new"
elsif input == 5 && room2_look == 1;
  puts "you see a hole filled with blackness"
elsif input == 6 && room2_look == 1 && knife == 0
  puts "you take the knife"
  knife = 1
  player_attack = 5
  player_weapon = "knife"
elsif input == 6 && room2_look == 1 && knife == 1
  puts "you already took the knife"
elsif input == 7;
  puts "you go back to the dark room"
  room = 1
end 
end
#room 3 ----------------------------------
if room == 3;
puts "    1: go through door A\n    2: look around"
if room3_look == 1 && sword == 0
  puts "    3: take the sword"
end
puts "    4: go back"
input = gets.chomp.to_i
if input == 1; 
  puts "you go through the door"
  puts " you find a small room with a wooden chest"
  room = 4
  #game_end =1
elsif input == 2 && room3_look == 0
  puts "you find a sword"
  room3_look = 1
elsif input == 2 && room3_look == 1
  puts "you find nothing new"
elsif input == 3 && sword == 0
  puts "you take the sword"
  sword = 1
  player_attack = 10
  player_weapon = "sword"
elsif input == 3 && sword ==1
  puts "you already took the sword"
elsif input == 4
  puts "you go back to the room with crumbling rocks"
  room = 2
end
end
#room 4 ----------------------------------
if room == 4;
puts "    1: open the wooden chest\n    2: look around"
if room4_look ==1 && sheild ==0
  puts "    3: take the sheild"
end
if room4_look ==1
puts "    4: read the note"
end
puts "    5: go back"
input = gets.chomp.to_i
if input == 1
  puts "as you go to open the chest, the top opens to show TEETH!\nIt jumps forward and chomps you in half.\n    You Die."
  game_end = 1
elsif input == 2 && room4_look == 0;
  puts "you find a corpse with a sheild and a note"
  room4_look = 1
elsif input == 2 && room4_look == 1;
  puts "you find nothing new"
elsif input == 3 && room4_look ==1 && sheild ==0;
  puts "you take the sheild."
  sheild = 1
  hp = hp + 5
  hpMax = hpMax + 5
elsif input == 3 && room4_look ==1 && sheild ==1;
  puts "you already took the sheild"
elsif input == 4 && room4_look == 1;
  puts "THE NOTE:\n   the wooden chests are mimics.\n   they are actually beasts that will eat you if you open them.\n   Also, the door in the middle of the big room back there is trapped,\n   the floor opens out from under you and you will die.\n   Be careful\n ~Gerald"
elsif input ==5 
  puts "you go back to the room with the small hall."
  room = 3
end
end
#room 5 ----------------------------------
if room == 5;
  puts "As you walk in to the room the floor opens out from under you!\nAs you fall, the spikes below you aren't that inviting...\n    You Die."
  game_end = 1
end
#room 6 ----------------------------------
if room == 6;
puts "    1: go through door A\n    2: look around\n    3: go back"
input = gets.chomp.to_i
if input == 1
  puts "you go through the door.\nYou enter a long hallway curved at the end.\nDo You:"
  room = 7
  elsif input == 2
  puts "you find nothing."
elsif input == 3
  puts "you go back to the room with the crumbling rocks"
  room = 2
end
end
#room 7 ----------------------------------
if room == 7;
puts "    1: walk forward\n    2: look around\n"
if room7_look == 1 
  puts "    3: inspect corpse"
end
if room7_look == 1 && room7_breakwall == 0
  puts "    4: inspect stonework"
end
if room7_look == 1 && room7_breakwall == 1
  puts "    5: break wall"
end
if room7_look == 1 && room7_breakwall == 2
  puts "    6: go through the hole"
end
puts "    7: go back"
input = gets.chomp.to_i
if input == 1
  puts "you walk down the hall way"
  room = 9
  #game_end = 1
elsif input == 2 && room7_look == 0
  puts "you find a corpse and a weird section of stonework on the wall"
  room7_look = 1
elsif input == 2 && room7_look == 1
  puts "you find nothing new"
elsif input == 3 && room7_look == 1
  puts "the corpse has nothing."
elsif input == 4 && room7_look == 1
  puts "you discover that the wall can be broken."
  room7_breakwall = 1
elsif input == 5 && room7_look == 1 && room7_breakwall == 1
  puts "you smash down the wall!"
  room7_breakwall = 2
elsif input == 5 && room7_look == 1 && room7_breakwall == 2
  puts "you already broke the wall"
elsif input == 6 && room7_look == 1 && room7_breakwall == 2
  puts "you go through the hole in the wall."
  puts "you enter a small room with a couple of chests"
  room = 8 
  #game_end =1
elsif input == 7 
  puts "you go back to the small corridoor"
  room =6
end
end
#room 8 ----------------------------------
if room == 8;
  if room8_zombieHP >0 && room == 8
    puts "ZOMBIE ATTACK!!!"
  end
  while room8_zombieHP > 0 && room == 8
    puts "    1: Hit Zombie\n    2: Run!"
    input = gets.chomp.to_i
  if input == 1
      puts "you hit the zombie with your #{player_weapon}"
      room8_zombieHP = room8_zombieHP - player_attack
    if room8_zombieHP <= 0
        puts "the zombie dies"
  	elsif room8_zombieHP > 0
	    puts "the zombie hits back"
	    hp = hp - 1
  	  puts "you take 1 damage. you have #{hp} hp"
	end
  elsif input == 2
    puts "you run away!"
	room = 7
  end
  if hp == 0
    puts "you die"
    exit
  end
  end
if room8_zombieHP <=0
puts "    1: open the wooden chest\n    2: open the iron chest\n    3: look around\n    4: go back"
input = gets.chomp.to_i
if input == 1
  puts "as you go to open the chest, the top opens to show TEETH!\nIt jumps forward and chomps you in half.\n    You Die."
  game_end = 1
elsif input == 2 && room8_chest == 0
  puts "you find two potions of full health and a greatsword."
  potion_fullHealth = 2
  greatsword = 1
  player_attack = 20
  player_weapon = "greatsword"
  room8_chest = 1
elsif input == 2 && room8_chest == 1
  puts "you already opened the chest"
elsif input == 3
  puts "you find nothing else"
elsif input == 4
  puts "you go back to the curved hallway"
  room = 7
end
end
end
#room 9 ----------------------------------
if room == 9;
room9_run = 0
if room9_zombieHP > 0
  puts " ZOMBIE ATTACK!!!"
end
while room9_zombieHP > 0 && room9_run == 0
puts "    1: Hit Zombie\n    2: Run!"
if potion_fullHealth > 0 
  puts "    3: drink potion"
end
    input = gets.chomp.to_i
  if input == 1
      puts "you hit the zombie with your #{player_weapon}"
      room9_zombieHP = room9_zombieHP - player_attack
    if room9_zombieHP <= 0
        puts "the zombie dies"
  	elsif room9_zombieHP > 0
	    puts "the zombie hits back"
	    hp = hp - 1
  	  puts "you take 1 damage. you have #{hp} hp"
	end
  elsif input == 2
    puts "you run away!"
	room9_run = 1
	room = 7
  elsif input == 3 && potion_fullHealth > 0
    puts "you step back and drink you potion"
	potion_fullHealth = potion_fullHealth -1
	hp = hpMax
  end
  if hp == 0
    puts "you die"
exit
  end  
end
if room9_zombieHP <=0
  puts "    1: go through door A\n    2: look around\n    3: go back"
  input = gets.chomp.to_i
  if input == 1
    puts "you go through the door"
	puts "you enter a room from the south east side, there are pillars in rows down the middle.\nthe room is also lit up with torches."
	room = 10
  elsif input == 2
    puts "you find nothing."
  elsif input == 3
    puts "you go back to the other side of the hall."
	room = 7
  end
end
end
#room 10 ---------------------------------
if room == 10;
puts "    1: walk west\n    2: walk north\n    3: look around\n    4: go back"
input = gets.chomp.to_i
if input == 1
  puts "you walk into the middle of the room"
  room = 11
elsif input == 2
  puts "you walk behind the pillars and down the room"
  room = 14
elsif input == 3 && room10_look == 0 && (room11_zombie1_HP >0 || room11_zombie2_HP > 0)
  puts "you see two zombies in the middle of the room\n and an old hag behind the pillars on the other side."
  room10_look = 1
elsif input == 3 && room10_look == 0 && (room11_zombie1_HP <= 0 || room11_zombie2_HP <= 0)
  puts "you see a old hag on the other side of the room behind the pillars"
elsif input == 3 && room10_look == 1 
  puts "you find nothing else"
elsif input == 4
  puts "you go back to the end of the curved hallway"
  room = 9
end
end
#room 11 ---------------------------------
if room == 11;
if room11_zombie1_HP >0 || room11_zombie2_HP > 0
puts "TWO ZOMBIES ATTACK!!!"
end
while room11_zombie1_HP >0 || room11_zombie2_HP > 0
puts "    1: hit the first zombie\n    2: hit the second zombie\n    3: hit both zombies\n    4: run"
if potion_fullHealth>0
puts "    5: drink potion"
end
input = gets.chomp.to_i
if input == 1
  puts "you hit the first zombie with your #{player_weapon}."
  room11_zombie1_HP = room11_zombie1_HP - player_attack
  if room11_zombie1_HP <= 0 
    puts "the first zombie dies"
  end
elsif input == 2 
  puts "you hit the second zombie with your #{player_weapon}." 
  room11_zombie2_HP = room11_zombie2_HP - player_attack
  if room11_zombie2_HP <= 0
    puts "the second zombie dies"
  end
elsif input == 3
  puts "you hit both zombies with your #{player_weapon}."
  room11_zombie1_HP = room11_zombie1_HP - player_attack/2
  room11_zombie2_HP = room11_zombie2_HP - player_attack/2 
  if room11_zombie1_HP <=0
    puts "the first zombie dies"
  end
  if room11_zombie2_HP <= 0 
    puts"the second zombie dies"
  end
elsif input == 4
  puts "you flee back behind the pillars"
  room = 10
end
if room11_zombie1_HP > 0
  puts "the first zombie hits back"
  hp = hp -1
  puts "you take 1 damage. you have #{hp} hp"
end
if room11_zombie2_HP > 0
  puts "the second zombie hits back"
  hp = hp -1
  puts "you take 1 damage. you have #{hp} hp"
end
if hp <=0 
puts "the zombies kill and eat you.\n You Die"
exit
end
end
if room11_zombie1_HP <= 0 && room11_zombie2_HP <= 0 
  puts "    1: go to the south side\n    2: go to the west side of the room behind the pillars\n    3: go to the north of the room\n    4: go to the south east of the room behind the pillars\n    5:look around"
input = gets.chomp.to_i
if input == 1
  puts "you go behind where the zombies were."
  room = 15
elsif input == 2
  puts "you go behind the pillars on the west side"
  room = 13
elsif input == 3 
  puts "you go to north side of the room opposite from where the zombies were."
  room = 12
  puts "you see a door."
elsif input == 4
  puts "you go to the back south east side of the pillars."
  room = 10
elsif input == 5 && room11_look == 0
  puts "you see and old hag behind the pillars on the left\n two doors behind where the zombies were\n and a door on the other side of the room"
  room11_look = 1
elsif input == 5 && room11_look ==1 
  puts "you find nothing new"
end
end
end
#room 12 ---------------------------------
if room == 12;
puts "    1: go through the door\n    2: go to the north east side of the room\n    3: go to the west side of the room\n    4: go towards the middle of the room\n    5: look around"
input = gets.chomp.to_i
if input == 1 
  puts "you go through the door"
  room = 5
elsif input == 2 
  puts "you go to the north east side of the room."
  room = 14
elsif input == 3 
  puts "you move to the west side of the room."
  room = 13
elsif input == 4
  puts "you go to the center of the room."
  room = 11
elsif input == 5 && room12_look == 0 && (room11_zombie1_HP > 0 || room11_zombie2_HP >0)
  puts "you see a corpse off to the right and zombies towards the middle of the room"
  room12_look = 1
elsif input == 5 && room12_look == 0 && (room11_zombie1_HP <=0 || room11_zombie2_HP <= 0)
  puts "you see a corpse off to the right"
  room12_look = 1
elsif input == 5 && room12_look == 1
  puts "you see nothing new"
end
end
#room 13 ---------------------------------
if room == 13;
#puts room13_breakwall
puts "    1: go to the north side of the room\n    2: go to the middle of the room\n    3: look around"
  if room13_look == 1 
    puts "    4: trade with the old hag"
  end
  if room13_look == 1 && room13_breakwall == 0
    puts "    5: inspect weird stonework"
  end
  if room13_look == 1 && room13_breakwall == 1
    puts "    6: break the wall"
  end
  if room13_look == 1 && room13_breakwall == 2
    puts "    7: walk through the hole"
  end
  if room13_look ==1 && torch == 0
    puts "    8: take torch"
  end
input = gets.chomp.to_i
if input == 1 
  puts "you go to the north side of the room."
  room =12
elsif input == 2 
  puts "you go to th middle of the room"
  room = 11
elsif input == 3 && room13_look == 0
  puts "you see a old hag, a torch losely hanging on the wall, and a patch of weird stonework"
  room13_look = 1
elsif input == 3 && room13_look == 1
puts "you see nothing new"
elsif input == 4 && room13_look == 1
  puts "you trade with the old hag"
  puts "'please kind sir, im so hungry. i can't see to find any food anywhere.' she says."
  room = 40
elsif input == 5 && room13_look == 1 && room13_breakwall == 0
  puts "you discover that the wall can be broken."
  room13_breakwall = 1
elsif input == 6 && room13_look == 1 && room13_breakwall == 1 
  puts "you smash the wall down."
  room13_breakwall = 2 
elsif input == 6 && room13_look == 1 && room13_breakwall == 2 
  puts "you already broke the wall"
elsif input == 7 && room13_look == 1 && room13_breakwall == 2
  puts "you walk through the hole."
  puts "you enter a small room with a iron chest."
  room = 16 
elsif input = 8 && room13_look == 1 
  puts "you take the torch"
  torch =1  
end 
end
# Old Hag Trading=========================
if room == 40
puts "you begin trading with the hag."
if sword == 1 && skullOfUlamog == 0
puts"    1: trade sword for skull of ulamog (can control Ulamog)."
end
if apple == 1
puts "    2: give apple."
end
puts "    3: stop trading"
input = gets.chomp.to_i
if input == 1 && sword == 1
  puts "you give her the sword and recieve a Skull of Ulamog!"
  sword = 0
  if knife == 1 && greatsword == 0
    puts "you take out you knife instead."
	player_weapon = "knife"
	player_attack = 5
  elsif greatsword == 1 
    puts "you give her your sword and keep your greatsword out."
  elsif knife == 0 && greatsword == 0
    puts "you give you oly weapon away. you go back to your fists."
	player_attack = 1 
	player_weapon = "fists"
  end
elsif input == 2
  puts "'thank you kind sir. heres something you may find useful.'\nshe gives you a potion fo full health"
  potion_fullHealth = potion_fullHealth + 1  
  apple = 0
elsif input == 3 
  puts "you stop trading"
  room = 13 
  end 
end
#room 14 ---------------------------------
if room == 14
puts "    1: go to the north side of the room.\n    2: go towards the south east side.\n    3: look around"
if room14_look == 1 && apple == 0
  puts "    4: take apple"
end
input = gets.chomp.to_i
if input == 1
  puts "you go to the north side of the room "
  room = 12
elsif input == 2 
  puts "you head along the pillars towards the south east side of the room"
  room = 10
elsif input == 3 && room14_look == 0
  puts "you see a corpse, the corpse has an apple with it."
  room14_look = 1
elsif input == 3 && room14_look == 1
  puts "you see nothing new"
elsif input == 4 && room14_look == 1
  puts "you take the apple."
  apple = 1
elsif input == 4 && room14_look == 1 && apple ==1 
  puts "you already took the apple"
end
end 
#room 15 ---------------------------------
if room == 15
puts "    1: go through door A\n    2: go through door B\n    3: go back to the middle of the room."
if room15_chest == 0
  puts "    4: open the iron chest"
end
input = gets.chomp.to_i
if input == 1 
  puts "you go through door A. you enter a hall way with a door at the end."
  room = 17
elsif input == 2 
  puts "you go through door B. you enter a room with a wooden barricade blocking you way."
  room = 19
elsif input == 3 
  puts "you go back to the middle of the room."
  room = 11
elsif input == 4 
  puts "you open the iron chest. you find a potion of full health and some broken rubbish."
  room15_chest = 1 
  potion_fullHealth = potion_fullHealth +1
end
end
#room 16 ---------------------------------
if room == 16 
if room16_chest == 0
puts "    1: open the iron chest."
end
puts "    2: go back"
input = gets.chomp.to_i
if input == 1 
  puts "you open the iron chest, you find a full set of armor. a chestplate, helm, pants, and boots. \nalso you find some random broken sticks as well. "
  chestplate = 1
  helm = 1
  leggings = 1
  boots = 1
  hp = hp + 40
  hpMax = hpMax + 40
  room16_chest = 1
elsif input == 2
  puts "you go back"
  room = 13 
end
end
#room 17 --------------------------------
if room == 17
puts "    1: go though door A\n    2: look around\n    3: go back"
input = gets.chomp.to_i
if input == 1 
  puts "you go though the door, then you enter an open area with a giant sleeping beast."
  room = 18
elsif input == 2
  puts "you see nothing."
elsif input == 3 
  puts "you go back to the big room."
  room = 15 
end
end
#room 18 --------------------------------
if room == 18 
puts "    1: stab the beast.\n    2: go back"
input = gets.chomp.to_i
if input == 1
  puts """
  you run forward and stab it!
  it spin around and smack syou against the wall.
  you take 50 damage.
  it jumps forwward, grabs you, and throws you up in the air.
  as you fall down, you realize that this wasn't the best of ideas.
  """
  game_end = 1 
elsif input ==  2 
  puts "you are smart and run back to the hallway."
  room = 17
end
end
#room 19 --------------------------------
if room == 19
puts "    1: go back"
if torch == 1 
puts "    2: burn the wood barricade"
end
if room19_burn == 1 
puts "    3: go past the ashes."
end
input = gets.chomp.to_i
if input == 1 
  puts "you go back to the room behind where the zombies were"
  room = 15
elsif input == 2 && torch == 1 
  puts "you burn the wall down."
  room19_burn = 1 
  torch = 0
elsif input == 3 && room19_burn == 1 
  puts "you stumble over the hot ashes and see a door."
  room = 20
end
end
#room 20 --------------------------------
if room == 20
puts "past the hot ashes there is a door.\n    1: go through the door\n    2: sift through the hot ashes\n    3: go back"
input = gets.chomp.to_i
if input == 1
  puts "you go through the door into a very small door with a door at the other end."
  room = 21
elsif input == 2 
  print "what are you doing?!?! you take 3 damage. " 
  hp = hp - 3
  puts "you have #{hp} hp."
elsif input == 3 
  puts "go back behind the hot ashes."
  room = 19 
end 
end
#room 21 --------------------------------
if room == 21 
  puts "    1: go through the door in front\n    2: look around\n    3: go back."
input = gets.chomp.to_i
if input == 1 
  puts "you enter a medium size room with a door on the right"
  room = 22
elsif input ==  2
  puts "you find nothing"
elsif input == 3 
  puts "you go back to the room with the hot ashes."
  room = 20
end 
end
#room 22 --------------------------------
if room == 22 
room22_run == 0
if room22_golem_HP >0
  puts "GOLEM ATTACK!!!"
end
while room22_golem_HP > 0 && room22_run == 0
puts "    1: hit the golem\n    2: run!"
if potion_fullHealth > 0
puts "    3: drink potion "
end
input = gets.chomp.to_i
if input == 1
  puts "you hit the golem with your #{player_weapon}"
  room22_golem_HP = room22_golem_HP - player_attack
  if room22_golem_HP <= 0 
    puts "the golem died"
  elsif room22_golem_HP > 0
    puts "the golem hits back\n you take 15 damage."
	hp = hp -15
	puts "you have #{hp} hp"
	if hp <=0
	puts "\t\tYou Die"
	exit
	end
  end
elsif input == 2 
  puts "you flee for your life!\n you are back in the small room."
  room = 21
  room22_run =1
elsif input == 3 && potion_fullHealth >0
puts "you step back and drink a potion."
hp = hpMax 
puts "you go back to #{hp} hp."
end
end
if room22_golem_HP <=0
puts "    1: go through the door on the right\n    2: look around\n    3: go back"
if room22_look == 1 && room22_potion_take == 0
puts "    4: take the potion."
end
input = gets.chomp.to_i
if input == 1 
  puts "you go through the door on the right."
  room = 23
elsif input == 2 && room22_look == 0
  puts "you look around and find that the golem dropped a potion"
  room22_look = 1
elsif input == 2 && room22_look == 1 
  puts "you see nothing more."
elsif input == 3
  puts "you go back to the tiny room."
  room = 21 
elsif input == 4 && room22_look == 1 && room22_potion_take == 0
  puts "you take the potion.\nit is a potion of full health."
  potion_fullHealth = potion_fullHealth + 1 
  puts "you have #{potion_fullHealth} potions of full health"
  room22_potion_take = 1
end
end
end 
#room 23 --------------------------------
if room == 23 
if room23_zombie1_HP >0 || room23_zombie2_HP > 0
puts "TWO ZOMBIES ATTACK!!!"
end
while room23_zombie1_HP >0 || room23_zombie2_HP > 0
puts "    1: hit the first zombie\n    2: hit the second zombie\n    3: hit both zombies\n    4: run"
if potion_fullHealth>0
puts "    5: drink potion"
end
input = gets.chomp.to_i
if input == 1
  puts "you hit the first zombie with your #{player_weapon}."
  room23_zombie1_HP = room23_zombie1_HP - player_attack
  if room23_zombie1_HP <= 0 
    puts "the first zombie dies"
  end
elsif input == 2 
  puts "you hit the second zombie with your #{player_weapon}." 
  room23_zombie2_HP = room23_zombie2_HP - player_attack
  if room23_zombie2_HP <= 0
    puts "the second zombie dies"
  end
elsif input == 3
  puts "you hit both zombies with your #{player_weapon}."
  room23_zombie1_HP = room23_zombie1_HP - player_attack/2
  room23_zombie2_HP = room23_zombie2_HP - player_attack/2 
  if room23_zombie1_HP <=0
    puts "the first zombie dies"
  end
  if room23_zombie2_HP <= 0 
    puts"the second zombie dies"
  end
elsif input == 4
  puts "you flee back to the medium size room"
  room = 22
end
if room23_zombie1_HP > 0
  puts "the first zombie hits back"
  hp = hp -1
  puts "you take 1 damage. you have #{hp} hp"
end
if room23_zombie2_HP > 0
  puts "the second zombie hits back"
  hp = hp -1
  puts "you take 1 damage. you have #{hp} hp"
end
if hp <=0 
puts "the zombies kill and eat you.\n You Die"
exit
end
end
if room23_zombie1_HP <=0 && room23_zombie2_HP <= 0
puts "    1: go forward\n    2: look around\n    3: go back"
input = gets.chomp.to_i
if input == 1
puts "you walk forward."
room = 24
elsif input == 2 && room23_look == 0
puts "you see two golems in the middle of the room and a giant beast behind them.\nbehind that beast is a door."
room23_look = 1
elsif input == 2 && room23_look == 1 
puts "you see nothing more."
elsif input == 3 
puts " you go back to the medium room."
room = 22 
end
end
end
#room 24 --------------------------------
if room == 24 
if room24_golem1_HP >0 || room24_golem2_HP > 0
puts "TWO GOLEMS ATTACK!!!"
end
while (room24_golem1_HP >0 || room24_golem2_HP > 0) && room24_run == 0 
puts "    1: hit the first golem\n    2: hit the second golem\n    3: hit both golems\n    4: run"
if potion_fullHealth>0
puts "    5: drink potion"
end
input = gets.chomp.to_i
if input == 1
  puts "you hit the first golem with your #{player_weapon}."
  room24_golem1_HP = room24_golem1_HP - player_attack
  if room24_golem1_HP <= 0 
    puts "the first golem dies"
  end
elsif input == 2 
  puts "you hit the second golem with your #{player_weapon}." 
  room24_golem2_HP = room24_golem2_HP - player_attack
  if room24_golem2_HP <= 0
    puts "the second golem dies"
  end
elsif input == 3
  puts "you hit both golems with your #{player_weapon}."
  room24_golem1_HP = room24_golem1_HP - player_attack/2
  room24_golem2_HP = room24_golem2_HP - player_attack/2 
  if room24_golem1_HP <=0
    puts "the first golem dies"
  end
  if room24_golem2_HP <= 0 
    puts"the second golem dies"
  end
elsif input == 4
  puts "you flee back to the start of the room."
  room = 23
  room24_run = 1 
elsif input == 5
puts "you step back and quickly chug you potion"
hp = hpMax
potion_fullHealth = potion_fullHealth - 1
end
if room24_golem1_HP > 0
  puts "the first golem hits back"
  hp = hp - 15
  puts "you take 15 damage. you have #{hp} hp"
end
if room24_golem2_HP > 0
  puts "the second golem hits back"
  hp = hp -15
  puts "you take 15 damage. you have #{hp} hp"
end
if hp <=0 
puts "the golems smash you to bits.\n You Die"
exit
end
end
if room24_golem1_HP <=0 && room24_golem2_HP <= 0
puts "    1: go forward\n    2: look around\n    3: go back"
if room24_look == 1 && room24_potion_take == 0
puts "    4: take both potions"
end
input = gets.chomp.to_i
if input == 1
puts "go go towards the back of thye room"
room = 25
elsif input == 2 && room24_look == 0
puts "you see a giant beast in front of you, and two potions on the floor on the golems"
room24_look = 1 
elsif input == 2 && room24_look == 1 
puts "you see nothing else."
elsif input == 3 
puts "you go back to the beginning of the room."
room = 23 
elsif input == 4 && room24_look == 1 && room24_potion_take == 0
puts "you take both potions"
potion_fullHealth = potion_fullHealth +2 
puts " you have #{potion_fullHealth} potions"
room24_potion_take = 1
elsif input == 4 && room24_look == 1 && room24_potion_take == 1
puts "you already took the potions."
end
end
end
#room 25 --------------------------------
if room == 25 
puts """
you walk forward.
a Gigantic bear-lizard beast in front of you stirs...
it opens it's eyes, pauses, then bellows so loud it hurts you ears!

it bounds at you
do you:
    1:swing at it\n    2:Run For Your Life!!!
"""
input = gets.chomp.to_i
if input == 1 
puts "you swing at the beast and it stops up short in front of you.\nIt bellows again!"
room = 26
else 
puts "you turn to leave, it continues to bound at you...   \nit grabs you in it's paws, you are tossed up in the air and eaten.\n\tYou Die"
game_end = 1 
end
end
#room 26 final boss ---------------------
if room  == 26 
puts "    1: swing at it\n    2: run"
if potion_fullHealth >0
puts "    3: drink potion"
end
input = gets.chomp.to_i
if input == 2 
puts "you turn to flee, the bear-lizard beast grabs and eats you."
game_end = 1 
elsif input == 3 
puts "you quickly chug a potion."
potion_fullHealth = potion_fullHealth - 1 
hp = hpMax
puts "your hp goes back to #{hp}"
elsif input == 1
print "you swing at it, it jumps back and "
if bossHp <= 200 && bossHp >=180 #-------
puts "swipes at you with its left hand\n do you"
puts "    1: dodge\n    2: stab its hand."
input = gets.chomp.to_i
if input == 1
puts "you go to dodge, you get smacked against the wall.\nyou take 20 damage"
hp = hp -20 
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
elsif input == 2 
puts "you stab it in the hand and bring its hand over your head."
bossHp = bossHp - player_attack
else
puts"it grabs and eats you"
game_end = 1 
end
elsif bossHp <= 179 && bossHp >=160#-----
puts "then jumps forward to bite you\ndo you"
puts "    1: dodge\n    2: stab it in the face!"
input = gets.chomp.to_i
if input == 1 
puts "you jump to the side, the bear-lizard merely turns and bites you\n it hurts."
hp = hp -30 
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
elsif input == 2 
puts "you stab its face!\nIts mad."
bossHp = bossHp-player_attack
else
puts"it eats you"
game_end = 1 
end
elsif bossHp <= 159 && bossHp >=140#-----
puts "stands up. it raises both hands and brings them down at you.\ndo you "
puts "    1: dodge\n    2: stab its hands."
input = gets.chomp.to_i
if input == 1
puts "you roll out of the way just in time!\n It hits the ground so hard the stone floor cracks."
puts "    1: stab its hands now!\n    2: run."
input = gets.chomp.to_i
if input == 1
	puts "you slash its hands!"
	bossHp = bossHp-player_attack
elsif input == 2 
	puts "you turn to go, it leaps forward and smacks you agaist the wall!\nyou take 20 damage"
	hp = hp - 20 
	puts "you have #{hp} hp."
	if hp<=0; puts "\tYou Die"; exit end
end 
elsif input == 2 
puts "you stab at its hands, it continues to bring its hands down on top of you and your #{player_weapon}!\nyou take 50 damage!"
hp = hp - 50
bossHp = bossHp-player_attack
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
else
puts"it grabs and eats you"
game_end = 1 
end 
elsif bossHp <= 139 && bossHp >=120#-----
puts "swipes at you with its right hand\ndo you"
puts "    1: stab its hand\n    2: jump over its hand."
input = gets.chomp.to_i
if input == 1 
puts "you go to stab its hand, it pulls its hand back at the last moment,\nthen brings its hand back and smacks you against the wall.\n you taek 20 damage"
hp = hp - 20 
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
elsif input == 2 
puts "you nimbly hop over its hand.\n    1: stab its shoulder.\n    2: run"
input = gets.chomp.to_i
if input == 1 
	puts "you stab it in the shoulder, it isn't happy with you."
	bossHp = bossHp-player_attack
elsif input == 2 
	puts "you go to run, it backhands you againts the wall.\n you take 20 damage"
	hp =hp - 20 
	if hp<=0; puts "\tYou Die"; exit end
end 
end
elsif bossHp <= 119 && bossHp >=100#-----
puts "swipes at you with its left hand\n do you"
puts "    1: dodge\n    2: stab its hand."
input = gets.chomp.to_i
if input == 1
puts "you go to dodge, you get smacked against the wall.\nyou take 20 damage"
hp = hp -20 
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
elsif input == 2 
puts "you stab it in the hand and bring its hand over your head."
bossHp = bossHp - player_attack
else
puts"it grabs and eats you"
game_end = 1 
end
elsif bossHp <= 99 && bossHp >=80#-----
puts "then jumps forward to bite you\ndo you"
puts "    1: dodge\n    2: stab it in the face!"
input = gets.chomp.to_i
if input == 1 
puts "you jump to the side, the bear-lizard merely turns and bites you\n it hurts."
hp = hp -30 
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
elsif input == 2 
puts "you stab its face!\nIts mad."
bossHp = bossHp-player_attack
else
puts"it eats you"
game_end = 1 
end
elsif bossHp <= 79 && bossHp >=60#-----
puts "spins to hit you with its tail.\n    1: stab its tail\n    2: jump over"
input = gets.chomp.to_i
if input == 1 
puts "you try to cleave part of its tail, you #{player_weapon} bounces off its armor.\nthe tail then its you in the waist and smashes you against the wall\nyou take 25 damage."
hp = hp - 25
puts "you have #{hp} hp"
elsif input == 2 
puts "you leap over the tail but you shoe gets caught on the tail.\nyou face plant the ground.\nyou take 2 damage"
hp = hp-2 
puts "you have #{hp} hp\nyou get up...\n    1: stab it in the leg\n    2: run"
input = gets.chomp.to_i
if input == 1 
	puts "you shank the bear-lizard in the leg, it spins back around to face you."
	bossHp = bossHp-player_attack
elsif input == 2 
	puts "you turn to leave, the bear-lizard turns around to face you...\nit leaps forward and bites down on your torso.\n\tYou Die"
	game_end = 1 
end 
else
puts"it eats you"
game_end = 1 
end
elsif bossHp <= 59 && bossHp >=40#-----
puts "swipes at you with its right hand\ndo you"
puts "    1: stab its hand\n    2: jump over its hand."
input = gets.chomp.to_i
if input == 1 
puts "you go to stab its hand, it pulls its hand back at the last moment,\nthen brings its hand back and smacks you against the wall.\n you take 20 damage"
hp = hp - 20 
puts "you have #{hp} hp"
if hp<=0; puts "\tYou Die"; exit end
elsif input == 2 
puts "you nimbly hop over its hand.\n    1: stab its shoulder.\n    2: run"
input = gets.chomp.to_i
if input == 1 
	puts "you stab it in the shoulder, it isn't happy with you."
	bossHp = bossHp-player_attack
elsif input == 2 
	puts "you go to run, it backhands you againts the wall.\n you take 20 damage"
	hp =hp - 20 
	if hp<=0; puts "\tYou Die"; exit end
end 
else
puts"it eats you"
game_end = 1 
end
elsif bossHp <= 39 && bossHp >=20#-----
puts "swings at you with both hands, one on each side.\n    1: stab the left hand\n    2: stab the right hand\n    3: dodge"
input = gets.chomp.to_i
if input == 1 
puts "you stand the left hand and bring it over your head, but the right hand hits you across the floor.\nyou take 15 damage"
hp = hp - 15
puts "you have #{hp} hp"
bossHp = bossHp-10
elsif input == 2 
puts "you stand the right hand and bring it over your head, but the left hand hits you across the floor.\nyou take 15 damage"
hp = hp - 15
puts "you have #{hp} hp"
bossHp = bossHp-10
elsif input == 3 
puts "you jump back but are to slow, the hands clap you together.\nyou take 40 damage."
hp =hp - 40
puts "you have #{hp} hp."
else
puts"it eats you"
game_end = 1 
end
if hp<=0; puts "\tYou Die"; exit end
elsif bossHp <= 19 && bossHp >0#-----
puts "spits an acid like substance at you\n    1: jump to the side.\n    2: jump backwards"
if sheild == 1 
puts "    3: block with your sheild"
end
input = gets.chomp.to_i
if input == 3 
puts "you block with your sheild, the acid corrodes the sheild,\n you toss the corroded sheild to the side.\nyou look up, you see the inside of the bear-lizards throat...\n\tyou are eaten"
game_end = 1
elsif input == 2 
puts """
you jump back.
but it wasn't a sideways attack,
the acid also goes back with you.
you are now in a pool of acid...

you slowly corrode away to nothing
	You Die
"""
game_end = 1 
elsif input == 1 
puts "you jump to the side, the acid flies past you!\n    1: run towards its face.\n    2: run away."
input = gets.chomp.to_i
if input == 2 
puts "you turn to flee, it jumps forward and eats you."
game_end = 1 
elsif input == 1 
	puts "you run towards the bear-lizard\nit takes a grab at you.\n    1: dodge\n    2: slash down at its hand."
	input = gets.chomp.to_i
	if input == 1 
		puts "you try to dodge, but it still grabs you.\n you are brought to his mouth and eaten.\n\tYou Die"
		game_end = 1
	elsif input == 2 
		puts "you chop off a few fingers\nyou leap over the lacerated arm,\n    1: stab it in the chest\n    2: slash its neck"
		input = gets.chomp.to_i
		if input == 1 
			puts "you try to stab its chest but your #{player_weapon} bounces off its chest armor!\nit quickly leans down and eats you.\n\tYou Die"
			game_end = 1 
		elsif input == 2
			puts "you slash through half its neck,\nit tries to cry out but all that comes out is a wet gurgle.\nit collapses on the floor."
			bossHp = 0
		end
	end
end 
else
puts"it eats you"
game_end = 1 
end
end
if bossHp ==0#-----
puts """
the thing dies.
it slowly starts to crumble to dust.
as it blows away you see a key on the ground.
there is a door behind where the bear-lizard was. 
you try the key in the door. 
it opens, you step out in to the sunlight... 


Good Job, you are one of the few to beat this game.
some of the people to test my game are:
My Parents
Cooper Hammond
Tyler Bishop
Luke Deuchars
Garrett Kawaguchi
Craig Rankin
Annie Ayers
and a few more.


thank you.
"""
sleep = 15
game_end = 1
end
end
end
end
sleep 15