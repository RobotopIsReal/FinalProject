#!/bin/bash
#player stats
gold=10
atk=1
def=0
hp=10
critchance=8
floor=1
enemies=("goblin" "skeleton")


dungeon_begin(){
	echo "You enter Floor $floor.
	|| 1) Enter shop
	|| 2) Fight enemy
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
	|| Stats: $atk Attack | $hp Health | $def Defense | $critchance% CritChance | $gold Gold"
	read -p "Choose upgrade: " shop_input
	shop_choice
}
#crit chance was meant to be a set chance that your attacks do double damage per attack cycle. defense would make each attack do 1 less damage (for example, 3 attack would do 2 damage per attack cycle with 1 defense)

#enemy fighting --------------------------------
set_current_enemy(){
	enemy=(${enemies[RANDOM%1]})
	echo $enemy
}
#was meant to help with making fight_monster support other monster types. currently set to RANDOM%1 so it only picks goblin.

fight_monster(){
	echo "You encounter a $enemy!"
	echo "Enemy stats: ${goblin_enemy[0]} ATK | ${goblin_enemy[1]} DEF | ${goblin_enemy[2]} HP"
	while (( enemyhp >= -5 ))
	do
		hp=$((hp - enemyatk))
		enemyhp=$(($enemyhp - atk))
		echo "$hp $enemyhp"
	done
}
#was meant to support all enemy types. while loop was meant to print out both your and the enemy's health values for every attack (attacks subtract both hp values by the opposite attack values)
#defense and critting is also unimplemented
#around 20% done

#chest looting -------------------------------
loot_chest(){
	echo "You try to open the chest.. It's trapped!"
	equation
}

equation(){
	number1=$((RANDOM%10))
	number2=$((RANDOM%10))
	read -t 5 -p "What is $number1 - $number2? " answer
	if [ -n "$answer" ]; then
		if [ $answer = $((number1 - number2)) ]; then
			echo "You open the chest! Inside you find 15 Gold!"
			gold=$((gold + 15))
			sleep 1
			dungeon_begin
		else
			chest_explosion
		fi
	else
		chest_explosion
	fi
}
#prompts the user with a random question (placeholder equation was a subtraction question with 2 numbers 1-10) and checks if the number is correct
#around 95% done, just needed to figure out what the equation shouldve been

chest_explosion(){
		echo "
		/// The chest exploded! Game over! ///"
		exit 1
}

#shop upgrades -------------------------------
sword_upgrade(){
	if (( gold >= 10 )) then
		echo "Upgraded Attack by 1!"
		atk=$((atk + 1))
		gold=$((gold - 10))
	else
		echo "Insufficient funds!"
	fi
	sleep 1
	enter_shop
}

armor_upgrade(){
	if (( gold >= 10 )) then
		echo "Upgraded Health by 1!"
		hp=$((hp + 1))
		gold=$((gold - 10))
	else
		echo "Insufficient funds!"
	fi
	sleep 1
	enter_shop
}
#both this and sword upgrade simply increase your stats and subtract your gold, both are fully done

#indexes represent in order: Attack, Defense, Health and Loot.
goblin_enemy=(2 0 5 5)
skeleton_enemy=(2 0 6 8)


#shop case
shop_choice(){
	case $shop_input in
	1)
		sword_upgrade
		;;
	2)
		armor_upgrade
		;;
	esac
}




#main case
send_to_choice(){
case $input in
1)
	enter_shop
	;;
2)
	set_current_enemy
	fight_monster
	;;
3)
	loot_chest
	;;
4)
	set_current_enemy
	;;
*)
	echo "Invalid input!"
	;;
esac
}
#more planned options included file saving, file loading, potentially more ways to earn gold other than chest looting.

# begins the loop
dungeon_begin
enemyhp=${goblin_enemy[2]}
enemyatk=${goblin_enemy[0]}
