#!/bin/bash
#player stats
gold=0
atk=1
def=0
hp=5
critchance=8
floor=1
enemies=("goblin" "skeleton")
dungeon_begin(){
	echo "You enter Floor $floor.
	|| 1) Enter shop
	|| 2) Fight $monster ($monsteratk|$monsterhp)
	|| 3) Loot chest"
	read -p "Enter selection: " input
	send_to_choice
}

enter_shop(){
	echo "Welcome to the shop!
	|| 1) Sword upgrade (+1 ATK) - 10G
	|| 2) Armor upgrade (+1 HP) - 10G
	|| 3) Skill upgrade (+2% CRIT) - 10G
	|| 4) Shield upgrade (+1 DEF) - 30G
	|| 5) Return
	|| Stats: $atk Attack | $hp Health | $def Defense | $critchance% CritChance"
	read -p "Choose upgrade: " shop_input
}

fight_monster(){
	echo "You encounter a $enemies!"
	echo "${goblin_enemy[0]}"
}

#indexes represent in order: Attack, Defense, Health and Loot.
goblin_enemy=(1 0 4 5)
skeleton_enemy=(2 0 6 8)

#main case
send_to_choice(){
case $input in
1)
	enter_shop
	;;
2)
	fight_monster
	;;
3)
	loot_chest
	;;
*)
	echo "Invalid input!"
	;;
esac
}

# begins the loop
dungeon_begin